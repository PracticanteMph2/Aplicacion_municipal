import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/models.dart';
import '../state/app_state.dart';
import '../theme.dart';
import '../utils/visuals.dart';
import '../utils/time_utils.dart';
import '../widgets/common.dart';
import 'package:url_launcher/url_launcher.dart';
import 'proceso_canje.dart';

/// Pantalla de beneficios (Vista dual: Municipales / Afiliados).
class BeneficiosScreen extends StatefulWidget {
  const BeneficiosScreen({super.key});

  @override
  State<BeneficiosScreen> createState() => _BeneficiosScreenState();
}

class _BeneficiosScreenState extends State<BeneficiosScreen> {
  bool _viewA = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PhColors.bg,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Container(
              color: Colors.white,
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
              child: Row(
                children: [
                  Expanded(
                    child: _Toggle(
                      label: 'Municipales',
                      active: _viewA,
                      onTap: () => setState(() => _viewA = true),
                    ),
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: _Toggle(
                      label: 'Comercios Afiliados',
                      active: !_viewA,
                      onTap: () => setState(() => _viewA = false),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: _viewA ? const _LayoutA() : const _LayoutB(),
            ),
          ],
        ),
      ),
    );
  }
}

class _Toggle extends StatelessWidget {
  final String label;
  final bool active;
  final VoidCallback onTap;
  const _Toggle({required this.label, required this.active, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 6),
        decoration: BoxDecoration(
          color: active ? PhColors.green : PhColors.gray100,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: active ? Colors.white : PhColors.gray500,
          ),
        ),
      ),
    );
  }
}

const _tabs = ['Favoritos', 'Destacados', 'Salud', 'Gastronomía', 'Mascotas', 'Deporte', 'Servicios', 'Comercios'];

class _LayoutA extends StatefulWidget {
  const _LayoutA();

  @override
  State<_LayoutA> createState() => _LayoutAState();
}

class _LayoutAState extends State<_LayoutA> {
  //para el boton de busqueda
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose(){
    _searchController.dispose();
    super.dispose();
  }
  Widget _buildGlobalSearchResults(List<Benefit> all) {
    // Función para quitar acentos y facilitar la búsqueda
    String normalize(String text) {
      return text.toLowerCase()
          .replaceAll('á', 'a')
          .replaceAll('é', 'e')
          .replaceAll('í', 'i')
          .replaceAll('ó', 'o')
          .replaceAll('ú', 'u');
    }

    final results = all.where((b) {
      final query = normalize(_searchQuery);
      return normalize(b.title).contains(query) ||
             normalize(b.description).contains(query) ||
             normalize(getCategoryMeta(b.category).name).contains(query); 
    }).toList();
    
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
      children: [
        Text(
          'Resultados para "$_searchQuery"',
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: PhColors.gray900),
        ),
        const SizedBox(height: 12),
        if (results.isEmpty)
          const EmptyBlock(message: 'No se encontraron comercios que coincidan'),
        ...results.map((b) => _BenefitTile(benefit: b)),
      ],
    );
  }
  
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    final all = state.benefits;

    return DefaultTabController(
      length: _tabs.length,
      child: Column(
        children: [
          ScreenHeader(
            title: 'Beneficios Municipales',
            color: PhColors.green,
            onBack: () => Navigator.of(context).maybePop(),
            titleWidget: _isSearching
              ? TextField(
                  controller: _searchController,
                  autofocus: true,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                  decoration: InputDecoration(
                    hintText: 'Buscar...',
                    hintStyle: TextStyle(color: Colors.white.withValues(alpha: 0.6)),
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                  ),
                  onChanged: (val) => setState(() => _searchQuery = val),
            )
            :null,
            right: IconButton(
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              onPressed: (){
                setState(() {
                  _isSearching =! _isSearching;
                  if (!_isSearching) {
                    _searchQuery = '';
                    _searchController.clear();
                  }
                });
              },
              icon: Icon(_isSearching ? Icons.close : Icons.search, color: Colors.white, size:20),
            ),
            bottom:
              TabBar(
                isScrollable: true,
                indicatorColor: Colors.white,
                indicatorWeight: 3,
                tabAlignment: TabAlignment.start,
                labelColor: Colors.white,
                unselectedLabelColor: Colors.white.withValues(alpha: 0.7),
                labelStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                dividerColor: Colors.transparent,
                tabs: _tabs.map((t) => Tab(text: t)).toList(),
              ),
          ),
          Expanded(
            child: (_isSearching && _searchQuery.isNotEmpty)
              ? _buildGlobalSearchResults(all)
              : TabBarView(
                children: _tabs.map((tabName) {
                  final list = tabName == 'Favoritos'
                      ? all.where((b) => b.favorite).toList()
                      : tabName == 'Destacados'
                          ? all.where((b) => b.isFeatured).toList()
                          : all.where((b) => getCategoryMeta(b.category).name == tabName).toList();

                  return ListView(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
                    children: [
                      if (tabName == 'Destacados') ...[
                        _buildCtaSalud(context),
                        const SizedBox(height: 16),
                      ],
                      Text(
                        tabName == 'Destacados' ? 'Beneficios destacados' : 'Beneficios · $tabName',
                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: PhColors.gray900),
                      ),
                      const SizedBox(height: 12),
                      if (list.isEmpty)
                        const EmptyBlock(message: 'Sin beneficios en esta categoría.'),
                      ...list.map((b) => _BenefitTile(benefit: b)),
                    ],
                  );
                }).toList(),
              ),
          ),
        ],
      ),
    );
  }

  Widget _buildCtaSalud(BuildContext context) {
    final state = context.watch<AppState>();
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: PhColors.blueTile, borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Beneficios del día', style: TextStyle(fontSize: 24, height: 1.0, fontWeight: FontWeight.w800, color: PhColors.blue)),
          const Text('Disponible hoy', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: PhColors.blue)),
          const SizedBox(height: 8),
          const Text('Descubre los beneficios de hoy disponibles para ti.', style: TextStyle(fontSize: 14, color: PhColors.gray700)),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () => _openTodayBenefits(context, state.benefits),
            style: ElevatedButton.styleFrom(
              backgroundColor: PhColors.blue,
              foregroundColor: Colors.white,
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: const Text('Ver disponibles hoy', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }
}

class _LayoutB extends StatefulWidget {
  const _LayoutB();

  @override
  State<_LayoutB> createState() => _LayoutBState();
}

class _LayoutBState extends State<_LayoutB> {
  String? _selectedCategory;

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    final benefits = state.benefits;

    if (_selectedCategory != null) {
      final list = benefits.where((b) => b.category == _selectedCategory).toList();
      final catMeta = getCategoryMeta(_selectedCategory);

      return Column(
        children: [
          ScreenHeader(
            title: catMeta.displayName,
            color: PhColors.blue,
            onBack: () => setState(() => _selectedCategory = null),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
              children: [
                if (list.isEmpty) const EmptyBlock(message: 'Sin beneficios en esta categoría.'),
                ...list.map((b) => _BenefitTile(benefit: b)),
              ],
            ),
          ),
        ],
      );
    }

    final counts = <String, int>{};
    for (final b in benefits) {
      counts[b.category] = (counts[b.category] ?? 0) + 1;
    }

    return Column(
      children: [
        ScreenHeader(
          title: 'Comercios Afiliados',
          color: PhColors.blue,
          onBack: () => Navigator.of(context).maybePop(),
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
            children: [
              const Text('Explora tus beneficios',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: PhColors.gray900)),
              const SizedBox(height: 12),
              ...counts.entries.map((e) {
                final m = getCategoryMeta(e.key);
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: GestureDetector(
                    onTap: () => setState(() => _selectedCategory = e.key),
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: PhColors.gray100),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(color: m.bg, borderRadius: BorderRadius.circular(12)),
                            child: Icon(m.icon, color: m.color, size: 20),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(m.displayName, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: PhColors.gray900)),
                                Text(m.desc, style: const TextStyle(fontSize: 12, color: PhColors.gray500)),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(color: PhColors.gray100, borderRadius: BorderRadius.circular(999)),
                            child: Text('${e.value}', style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: PhColors.gray500)),
                          ),
                          const Icon(Icons.chevron_right, color: PhColors.gray400, size: 20),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ],
    );
  }
}

// --- COMPONENTES REUTILIZABLES ---
class _BenefitTile extends StatelessWidget {
  final Benefit benefit;
  const _BenefitTile({required this.benefit});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: PhColors.gray100),
        ),
        child: Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () => showBenefitDetails(context, benefit),
                child: Row(
                  children: [
                    MerchantIcon(benefit: benefit),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(benefit.title,
                              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: PhColors.gray900)),
                          Text('${benefit.discount} · ${benefit.description}',
                              maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 12, color: PhColors.gray500)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                final wasFav = benefit.favorite;
                context.read<AppState>().toggleFavorite(benefit.id);
                showPhToast(context, wasFav ? 'Quitado de favoritos' : 'Agregado a favoritos');
              },
              icon: Icon(benefit.favorite ? Icons.favorite : Icons.favorite_border, color: PhColors.red, size: 20),
            ),
          ],
        ),
      ),
    );
  }
}
/// Muestra los beneficios del dia
void _openTodayBenefits(BuildContext context, List<Benefit> allBenefits){
  final availableNow = allBenefits.where((b) => TimeUtils.checkAvailability(b).isAvailable).toList();

  showPhSheet(
    context,
    title: 'Disponibles hoy',
    child: Column(
      children: [
        if (availableNow.isEmpty)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 40),
            child: EmptyBlock(message: 'No hay comercios disponibles el dia de hoy'),
          ),
        ...availableNow.map((b) => _BenefitTile(benefit: b)),
        const SizedBox(height: 20),
      ],
    ),
  );
}


/// Muestra la ficha detallada de un beneficio en un bottom sheet.
void showBenefitDetails(BuildContext context, Benefit b) {
  final availability = TimeUtils.checkAvailability(b);

  showPhSheet(
    context,
    title: b.title,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (b.img != null) ...[
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(
              b.img!,
              height: 180,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                height: 180,
                width: double.infinity,
                decoration: BoxDecoration(color: PhColors.blue.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(16)),
                child: const Icon(Icons.image_not_supported_outlined, color: PhColors.blue, size: 40),
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
        Row(
          children: [
            MerchantIcon(benefit: b, size: 56),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(b.title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: PhColors.gray900)),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(color: PhColors.gray100, borderRadius: BorderRadius.circular(999)),
                    child: Text(getCategoryMeta(b.category).name, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: PhColors.gray500)),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        if (b.customHours != null) ...[
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            decoration: BoxDecoration(
              color: availability.isAvailable ? PhColors.green.withValues(alpha: 0.1) : PhColors.gray100,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(availability.isAvailable ? Icons.check_circle : Icons.lock_clock,
                    size: 16, color: availability.isAvailable ? PhColors.green : PhColors.gray500),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(availability.message,
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: availability.isAvailable ? PhColors.green : PhColors.gray600)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
        ],
        if (b.offers != null && b.offers!.isNotEmpty) ...[
          const Text('Beneficios incluidos', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: PhColors.gray900)),
          const SizedBox(height: 8),
          ...b.offers!.map((offer) {
            final offerAvail = TimeUtils.checkAvailability(b, offer: offer);
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: InkWell(
                onTap: () => _openIndividualOffer(context, b, offer),
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: offerAvail.isAvailable ? PhColors.greenSoft : PhColors.gray100,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: offerAvail.isAvailable ? PhColors.green.withValues(alpha: 0.2) : PhColors.gray200),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.local_offer_outlined, color: offerAvail.isAvailable ? PhColors.green : PhColors.gray400, size: 20),
                      const SizedBox(width: 10),
                      Expanded(
                          child: Text(offer.title,
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: offerAvail.isAvailable ? PhColors.green : PhColors.gray500))),
                      const Icon(Icons.chevron_right, size: 18, color: PhColors.gray400),
                    ],
                  ),
                ),
              ),
            );
          }),
        ],
        const SizedBox(height: 12),
        const Text('Sobre el local', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: PhColors.gray900)),
        const SizedBox(height: 4),
        Text(b.description, style: const TextStyle(fontSize: 14, color: PhColors.gray600, height: 1.5)),
        const SizedBox(height: 16),
        if (b.schedule != null) ...[
          const Text('Horario de atención', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: PhColors.gray900)),
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(Icons.access_time, size: 14, color: PhColors.gray500),
              const SizedBox(width: 6),
              Expanded(child: Text(b.schedule!, style: const TextStyle(fontSize: 13, color: PhColors.gray600))),
            ],
          ),
          const SizedBox(height: 16),
        ],
        if (b.address != null)
          Row(
            children: [
              const Icon(Icons.location_on_outlined, size: 16, color: PhColors.blue),
              const SizedBox(width: 6),
              Expanded(child: Text(b.address!, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: PhColors.gray700))),
            ],
          ),
        const SizedBox(height: 4),
        Text(b.provider, style: const TextStyle(fontSize: 12, color: PhColors.gray500)),
        const SizedBox(height: 24),
        if (b.address != null)
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () async {
                final url = Uri.https('www.google.com', '/maps/search/', {'api': '1', 'query': b.address!});
                try {
                  if (await canLaunchUrl(url)) {
                    await launchUrl(url, mode: LaunchMode.externalApplication);
                  } else {
                    await launchUrl(url, mode: LaunchMode.platformDefault);
                  }
                } catch (e) {
                  showPhToast(context, 'No se pudo abrir el mapa');
                }
              },
              icon: const Icon(Icons.map_outlined, size: 18),
              style: OutlinedButton.styleFrom(
                  foregroundColor: PhColors.blue,
                  side: const BorderSide(color: PhColors.blue),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  textStyle: const TextStyle(fontSize: 13)),
              label: const Text('Ver ubicación en el mapa', style: TextStyle(fontWeight: FontWeight.w600)),
            ),
          ),
      ],
    ),
  );
}

void _openIndividualOffer(BuildContext context, Benefit b, Offer offer) {
  final availability = TimeUtils.checkAvailability(b, offer: offer);

  showPhSheet(
    context,
    title: 'Detalle del Beneficio',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(offer.title, style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: availability.isAvailable ? PhColors.green : PhColors.gray500, height: 1.2)),
        const SizedBox(height: 8),
        Text(b.merchant ?? b.title, style: const TextStyle(fontSize: 14, color: PhColors.gray500, fontWeight: FontWeight.w500)),
        const SizedBox(height: 24),
        if (!availability.isAvailable) ...[
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: PhColors.redSoft, borderRadius: BorderRadius.circular(12)),
            child: Row(
              children: [
                const Icon(Icons.info_outline, size: 18, color: PhColors.red),
                const SizedBox(width: 12),
                Expanded(child: Text(availability.message, style: const TextStyle(fontSize: 13, color: PhColors.red, fontWeight: FontWeight.bold))),
              ],
            ),
          ),
          const SizedBox(height: 24),
        ],
        const Text('Descripción', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: PhColors.gray900)),
        const SizedBox(height: 8),
        Text(offer.description, style: const TextStyle(fontSize: 15, color: PhColors.gray700, height: 1.5)),
        const SizedBox(height: 24),
        if (b.conditions != null && b.conditions!.isNotEmpty) ...[
          const Text('Condiciones de uso', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: PhColors.gray900)),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: PhColors.redSoft, borderRadius: BorderRadius.circular(12), border: Border.all(color: PhColors.red.withValues(alpha: 0.2))),
            child: Column(
              children: b.conditions!
                  .map((c) => Padding(
                        padding: const EdgeInsets.only(bottom: 6),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(Icons.info_outline, size: 14, color: PhColors.red),
                            const SizedBox(width: 8),
                            Expanded(child: Text(c, style: const TextStyle(fontSize: 13, color: Color(0xFF991B1B), height: 1.4))),
                          ],
                        ),
                      ))
                  .toList(),
            ),
          ),
          const SizedBox(height: 24),
        ],
        if (offer.specificConditions != null && offer.specificConditions!.isNotEmpty) ...[
          const Text('Condiciones específicas', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: PhColors.gray900)),
          const SizedBox(height: 8),
          ...offer.specificConditions!.map((cond) => Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Row(
                  children: [
                    const Icon(Icons.circle, size: 6, color: PhColors.gray400),
                    const SizedBox(width: 8),
                    Expanded(child: Text(cond, style: const TextStyle(fontSize: 13, color: PhColors.gray600))),
                  ],
                ),
              )),
          const SizedBox(height: 24),
        ],
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: !availability.isAvailable
                ? null
                : () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) => ProcesoCanjeScreen(benefit: b, offer: offer)));
                  },
            style: ElevatedButton.styleFrom(
              backgroundColor: PhColors.green,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              elevation: 0,
            ),
            child: const Text('Usar ahora', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ),
        ),
        const SizedBox(height: 12),
        const Center(child: Text('Presenta tu código al momento de pagar', style: TextStyle(fontSize: 12, color: PhColors.gray400))),
      ],
    ),
  );
}
