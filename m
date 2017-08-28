Received: from eggs.gnu.org ([2001:4830:134:3::10]:41860)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <intermediadc@hotmail.com>) id 1dmDIr-0006nb-9t
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 02:14:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <intermediadc@hotmail.com>) id 1dmDII-0001ER-SW
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 02:13:41 -0400
From: luigi burdo <intermediadc@hotmail.com>
Date: Mon, 28 Aug 2017 06:13:03 +0000
Message-ID: <AM5P194MB0132478A4ED8333EA2FFA940C89E0@AM5P194MB0132.EURP194.PROD.OUTLOOK.COM>
References: <mailman.4191.1503853034.21953.qemu-ppc@nongnu.org>,
	<AC464994-B6AC-4DBC-942D-8C5EA8ECCE0E@gmail.com>
In-Reply-To: <AC464994-B6AC-4DBC-942D-8C5EA8ECCE0E@gmail.com>
Content-Language: it-IT
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Qemu 2.10 rc4 build issue on BE (luigi burdo)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Programmingkid <programmingkidx@gmail.com>
Cc: "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>

Hi,

this is the log that was attached in my email.

i will test only i386 softmmu when will return at home

thanks

Luigi


./configure --target-list=3Dppc64-softmmu,ppc-softmmu,x86_64-softmmu,arm-so=
ftmmu,i386-softmmu --with-sdlabi=3D2.0 --with-gtkabi=3D3.0 --audio-drv-list=
=3Dpa,sdl,alsa --disable-werror
Install prefix    /usr/local
BIOS directory    /usr/local/share/qemu
binary directory  /usr/local/bin
library directory /usr/local/lib
module directory  /usr/local/lib/qemu
libexec directory /usr/local/libexec
include directory /usr/local/include
config directory  /usr/local/etc
local state directory   /usr/local/var
Manual directory  /usr/local/share/man
ELF interp prefix /usr/gnemul/qemu-%M
Source path       /home/amigaone/Downloads/qemu-2.10.0-rc4
C compiler        cc
Host C compiler   cc
C++ compiler      c++
Objective-C compiler clang
ARFLAGS           rv
CFLAGS            -O2 -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=3D2 -g
QEMU_CFLAGS       -I/usr/include/pixman-1  -pthread -I/usr/include/glib-2.0=
 -I/usr/lib64/glib-2.0/include -DNCURSES_WIDECHAR -D_GNU_SOURCE -m64 -D_GNU=
_SOURCE -D_FILE_OFFSET_BITS=3D64 -D_LARGEFILE_SOURCE -Wstrict-prototypes -W=
redundant-decls -Wall -Wundef -Wwrite-strings -Wmissing-prototypes -fno-str=
ict-aliasing -fno-common -fwrapv  -Wendif-labels -Wno-shift-negative-value =
-Wno-missing-include-dirs -Wempty-body -Wnested-externs -Wformat-security -=
Wformat-y2k -Winit-self -Wignored-qualifiers -Wold-style-declaration -Wold-=
style-definition -Wtype-limits -fstack-protector-strong -I/usr/include/p11-=
kit-1   -I/usr/include/libpng16 -I/usr/include/libdrm  -I/usr/include/libus=
b-1.0
LDFLAGS           -Wl,--warn-common -m64 -g
make              make
install           install
python            python -B
smbd              /usr/sbin/smbd
module support    no
host CPU          ppc64
host big endian   yes
target list       ppc64-softmmu ppc-softmmu x86_64-softmmu arm-softmmu i386=
-softmmu
gprof enabled     no
sparse enabled    no
strip binaries    yes
profiler          no
static build      no
pixman            system
SDL support       yes (2.0.5)
GTK support       yes (3.22.17)
GTK GL support    yes
VTE support       no
TLS priority      NORMAL
GNUTLS support    yes
GNUTLS rnd        yes
libgcrypt         no
libgcrypt kdf     no
nettle            yes (3.3)
nettle kdf        yes
libtasn1          yes
curses support    yes
virgl support     yes
curl support      no
mingw32 support   no
Audio drivers     pa sdl alsa
Block whitelist (rw)
Block whitelist (ro)
VirtFS support    yes
VNC support       yes
VNC SASL support  no
VNC JPEG support  yes
VNC PNG support   yes
xen support       no
brlapi support    no
bluez  support    no
Documentation     no
PIE               no
vde support       no
netmap support    no
Linux AIO support yes
ATTR/XATTR support yes
Install blobs     yes
KVM support       yes
HAX support       no
TCG support       yes
TCG debug enabled no
TCG interpreter   no
RDMA support      no
fdt support       yes
preadv support    yes
fdatasync         yes
madvise           yes
posix_madvise     yes
libcap-ng support no
vhost-net support yes
vhost-scsi support yes
vhost-vsock support yes
vhost-user support yes
Trace backends    log
spice support     no
rbd support       no
xfsctl support    no
smartcard support no
libusb            yes
usb net redir     no
OpenGL support    yes
OpenGL dmabufs    yes
libiscsi support  no
libnfs support    no
build guest agent yes
QGA VSS support   no
QGA w32 disk info no
QGA MSI support   no
seccomp support   no
coroutine backend ucontext
coroutine pool    yes
debug stack usage no
crypto afalg      no
GlusterFS support no
gcov              gcov
gcov enabled      no
TPM support       yes
libssh2 support   no
TPM passthrough   no
QOM debugging     yes
Live block migration yes
lzo support       no
snappy support    yes
bzip2 support     yes
NUMA host support yes
tcmalloc support  no
jemalloc support  no
avx2 optimization no
replication support yes
VxHS block device no




[$ make -j4
  GEN     ppc64-softmmu/config-devices.mak.tmp
  GEN     ppc-softmmu/config-devices.mak.tmp
  GEN     x86_64-softmmu/config-devices.mak.tmp
  GEN     arm-softmmu/config-devices.mak.tmp
  GEN     arm-softmmu/config-devices.mak
  GEN     x86_64-softmmu/config-devices.mak
  GEN     ppc-softmmu/config-devices.mak
  GEN     ppc64-softmmu/config-devices.mak
  GEN     i386-softmmu/config-devices.mak.tmp
  GEN     config-host.h
  GEN     qemu-options.def
  GEN     qmp-commands.h
  GEN     i386-softmmu/config-devices.mak
  GEN     qapi-types.h
  GEN     qapi-visit.h
  GEN     qapi-event.h
  GEN     qmp-marshal.c
  GEN     qapi-types.c
  GEN     qapi-visit.c
  GEN     qapi-event.c
  GEN     qmp-introspect.h
  GEN     qmp-introspect.c
  GEN     trace/generated-tcg-tracers.h
  GEN     trace/generated-helpers-wrappers.h
  GEN     trace/generated-helpers.h
  GEN     trace/generated-helpers.c
  GEN     module_block.h
  GEN     tests/test-qapi-types.h
  GEN     tests/test-qapi-visit.h
  GEN     tests/test-qmp-commands.h
  GEN     tests/test-qapi-event.h
  GEN     tests/test-qmp-introspect.h
  GEN     trace-root.h
  GEN     util/trace.h
  GEN     crypto/trace.h
  GEN     io/trace.h
  GEN     migration/trace.h
  GEN     block/trace.h
  GEN     chardev/trace.h
  GEN     hw/block/trace.h
  GEN     hw/block/dataplane/trace.h
  GEN     hw/char/trace.h
  GEN     hw/intc/trace.h
  GEN     hw/net/trace.h
  GEN     hw/virtio/trace.h
  GEN     hw/audio/trace.h
  GEN     hw/misc/trace.h
  GEN     hw/usb/trace.h
  GEN     hw/scsi/trace.h
  GEN     hw/nvram/trace.h
  GEN     hw/display/trace.h
  GEN     hw/input/trace.h
  GEN     hw/timer/trace.h
  GEN     hw/dma/trace.h
  GEN     hw/sparc/trace.h
  GEN     hw/sd/trace.h
  GEN     hw/isa/trace.h
  GEN     hw/mem/trace.h
  GEN     hw/i386/trace.h
  GEN     hw/i386/xen/trace.h
  GEN     hw/9pfs/trace.h
  GEN     hw/ppc/trace.h
  GEN     hw/pci/trace.h
  GEN     hw/s390x/trace.h
  GEN     hw/vfio/trace.h
  GEN     hw/acpi/trace.h
  GEN     hw/arm/trace.h
  GEN     hw/alpha/trace.h
  GEN     hw/xen/trace.h
  GEN     ui/trace.h
  GEN     audio/trace.h
  GEN     net/trace.h
  GEN     target/arm/trace.h
  GEN     target/i386/trace.h
  GEN     target/mips/trace.h
  GEN     target/sparc/trace.h
  GEN     target/s390x/trace.h
  GEN     target/ppc/trace.h
  GEN     qom/trace.h
  GEN     linux-user/trace.h
  GEN     qapi/trace.h
  GEN     accel/tcg/trace.h
  GEN     accel/kvm/trace.h
  GEN     nbd/trace.h
  GEN     trace-root.c
  GEN     util/trace.c
  GEN     crypto/trace.c
  GEN     io/trace.c
  GEN     migration/trace.c
  GEN     block/trace.c
  GEN     chardev/trace.c
  GEN     hw/block/trace.c
  GEN     hw/block/dataplane/trace.c
  GEN     hw/char/trace.c
  GEN     hw/intc/trace.c
  GEN     hw/net/trace.c
  GEN     hw/virtio/trace.c
  GEN     hw/audio/trace.c
  GEN     hw/misc/trace.c
  GEN     hw/usb/trace.c
  GEN     hw/scsi/trace.c
  GEN     hw/nvram/trace.c
  GEN     hw/display/trace.c
  GEN     hw/input/trace.c
  GEN     hw/timer/trace.c
  GEN     hw/dma/trace.c
  GEN     hw/sparc/trace.c
  GEN     hw/sd/trace.c
  GEN     hw/isa/trace.c
  GEN     hw/mem/trace.c
  GEN     hw/i386/trace.c
  GEN     hw/i386/xen/trace.c
  GEN     hw/9pfs/trace.c
  GEN     hw/ppc/trace.c
  GEN     hw/pci/trace.c
  GEN     hw/s390x/trace.c
  GEN     hw/vfio/trace.c
  GEN     hw/acpi/trace.c
  GEN     hw/arm/trace.c
  GEN     hw/alpha/trace.c
  GEN     hw/xen/trace.c
  GEN     ui/trace.c
  GEN     audio/trace.c
  GEN     net/trace.c
  GEN     target/arm/trace.c
  GEN     target/i386/trace.c
  GEN     target/mips/trace.c
  GEN     target/sparc/trace.c
  GEN     target/s390x/trace.c
  GEN     target/ppc/trace.c
  GEN     qom/trace.c
  GEN     linux-user/trace.c
  GEN     qapi/trace.c
  GEN     accel/tcg/trace.c
  GEN     accel/kvm/trace.c
  GEN     nbd/trace.c
  GEN     config-all-devices.mak
  CC      tests/qemu-iotests/socket_scm_helper.o
  GEN     qga/qapi-generated/qga-qapi-types.h
  GEN     qga/qapi-generated/qga-qapi-visit.h
  GEN     qga/qapi-generated/qga-qmp-commands.h
  GEN     qga/qapi-generated/qga-qapi-types.c
  GEN     qga/qapi-generated/qga-qapi-visit.c
  GEN     qga/qapi-generated/qga-qmp-marshal.c
  CC      qmp-introspect.o
  CC      qapi-types.o
  CC      qapi-visit.o
  CC      qapi-event.o
  CC      qapi/qapi-visit-core.o
  CC      qapi/qobject-input-visitor.o
  CC      qapi/qapi-dealloc-visitor.o
  CC      qapi/qobject-output-visitor.o
  CC      qapi/qmp-registry.o
  CC      qapi/qmp-dispatch.o
  CC      qapi/string-input-visitor.o
  CC      qapi/string-output-visitor.o
  CC      qapi/opts-visitor.o
  CC      qapi/qapi-clone-visitor.o
  CC      qapi/qmp-event.o
  CC      qapi/qapi-util.o
  CC      qobject/qnull.o
  CC      qobject/qnum.o
  CC      qobject/qstring.o
  CC      qobject/qdict.o
  CC      qobject/qlist.o
  CC      qobject/qbool.o
  CC      qobject/qjson.o
  CC      qobject/qobject.o
  CC      qobject/json-lexer.o
  CC      qobject/json-streamer.o
  CC      qobject/json-parser.o
  CC      trace/control.o
  CC      trace/qmp.o
  CC      util/osdep.o
  CC      util/cutils.o
  CC      util/unicode.o
  CC      util/qemu-timer-common.o
  CC      util/bufferiszero.o
  CC      util/lockcnt.o
  CC      util/aiocb.o
  CC      util/async.o
  CC      util/thread-pool.o
  CC      util/qemu-timer.o
  CC      util/main-loop.o
  CC      util/iohandler.o
  CC      util/aio-posix.o
  CC      util/compatfd.o
  CC      util/event_notifier-posix.o
  CC      util/mmap-alloc.o
  CC      util/oslib-posix.o
  CC      util/qemu-openpty.o
  CC      util/qemu-thread-posix.o
  CC      util/memfd.o
  CC      util/envlist.o
  CC      util/path.o
  CC      util/module.o
  CC      util/host-utils.o
  CC      util/bitmap.o
  CC      util/bitops.o
  CC      util/hbitmap.o
  CC      util/fifo8.o
  CC      util/acl.o
  CC      util/cacheinfo.o
  CC      util/error.o
  CC      util/qemu-error.o
  CC      util/id.o
  CC      util/iov.o
  CC      util/qemu-config.o
  CC      util/qemu-sockets.o
  CC      util/uri.o
  CC      util/notify.o
  CC      util/qemu-option.o
  CC      util/qemu-progress.o
  CC      util/keyval.o
  CC      util/hexdump.o
  CC      util/crc32c.o
  CC      util/uuid.o
  CC      util/throttle.o
  CC      util/getauxval.o
  CC      util/readline.o
  CC      util/rcu.o
  CC      util/qemu-coroutine.o
  CC      util/qemu-coroutine-lock.o
  CC      util/qemu-coroutine-io.o
  CC      util/qemu-coroutine-sleep.o
  CC      util/coroutine-ucontext.o
  CC      util/buffer.o
  CC      util/timed-average.o
  CC      util/base64.o
  CC      util/log.o
  CC      util/qdist.o
  CC      util/qht.o
  CC      util/range.o
  CC      util/stats64.o
  CC      util/systemd.o
  CC      trace-root.o
  CC      util/trace.o
  CC      crypto/trace.o
  CC      io/trace.o
  CC      migration/trace.o
  CC      block/trace.o
  CC      chardev/trace.o
  CC      hw/block/trace.o
  CC      hw/block/dataplane/trace.o
  CC      hw/char/trace.o
  CC      hw/intc/trace.o
  CC      hw/net/trace.o
  CC      hw/virtio/trace.o
  CC      hw/audio/trace.o
  CC      hw/misc/trace.o
  CC      hw/usb/trace.o
  CC      hw/scsi/trace.o
  CC      hw/nvram/trace.o
  CC      hw/display/trace.o
  CC      hw/input/trace.o
  CC      hw/timer/trace.o
  CC      hw/dma/trace.o
  CC      hw/sparc/trace.o
  CC      hw/sd/trace.o
  CC      hw/isa/trace.o
  CC      hw/mem/trace.o
  CC      hw/i386/trace.o
  CC      hw/i386/xen/trace.o
  CC      hw/9pfs/trace.o
  CC      hw/ppc/trace.o
  CC      hw/pci/trace.o
  CC      hw/s390x/trace.o
  CC      hw/vfio/trace.o
  CC      hw/acpi/trace.o
  CC      hw/arm/trace.o
  CC      hw/alpha/trace.o
  CC      hw/xen/trace.o
  CC      ui/trace.o
  CC      audio/trace.o
  CC      net/trace.o
  CC      target/arm/trace.o
  CC      target/i386/trace.o
  CC      target/mips/trace.o
  CC      target/sparc/trace.o
  CC      target/s390x/trace.o
  CC      target/ppc/trace.o
  CC      qom/trace.o
  CC      linux-user/trace.o
  CC      qapi/trace.o
  CC      accel/tcg/trace.o
  CC      accel/kvm/trace.o
  CC      nbd/trace.o
  CC      crypto/pbkdf-stub.o
  CC      stubs/arch-query-cpu-def.o
  CC      stubs/arch-query-cpu-model-expansion.o
  CC      stubs/arch-query-cpu-model-comparison.o
  CC      stubs/arch-query-cpu-model-baseline.o
  CC      stubs/bdrv-next-monitor-owned.o
  CC      stubs/blk-commit-all.o
  CC      stubs/blockdev-close-all-bdrv-states.o
  CC      stubs/clock-warp.o
  CC      stubs/cpu-get-clock.o
  CC      stubs/cpu-get-icount.o
  CC      stubs/dump.o
  CC      stubs/error-printf.o
  CC      stubs/fdset.o
  CC      stubs/gdbstub.o
  CC      stubs/get-vm-name.o
  CC      stubs/iothread.o
  CC      stubs/iothread-lock.o
  CC      stubs/is-daemonized.o
  CC      stubs/linux-aio.o
  CC      stubs/machine-init-done.o
  CC      stubs/migr-blocker.o
  CC      stubs/change-state-handler.o
  CC      stubs/monitor.o
  CC      stubs/notify-event.o
  CC      stubs/qtest.o
  CC      stubs/replay.o
  CC      stubs/runstate-check.o
  CC      stubs/set-fd-handler.o
  CC      stubs/slirp.o
  CC      stubs/sysbus.o
  CC      stubs/trace-control.o
  CC      stubs/uuid.o
  CC      stubs/vm-stop.o
  CC      stubs/vmstate.o
  CC      stubs/qmp_pc_dimm_device_list.o
  CC      stubs/target-monitor-defs.o
  CC      stubs/target-get-monitor-def.o
  CC      stubs/pc_madt_cpu_entry.o
  CC      stubs/vmgenid.o
  CC      stubs/xen-common.o
  CC      stubs/xen-hvm.o
  CC      contrib/ivshmem-client/ivshmem-client.o
  CC      contrib/ivshmem-client/main.o
  CC      contrib/ivshmem-server/ivshmem-server.o
  CC      contrib/ivshmem-server/main.o
  CC      qemu-nbd.o
  CC      block.o
  CC      blockjob.o
  CC      qemu-io-cmds.o
  CC      replication.o
  CC      block/raw-format.o
  CC      block/qcow.o
  CC      block/vdi.o
  CC      block/vmdk.o
  CC      block/cloop.o
  CC      block/bochs.o
  CC      block/vpc.o
  CC      block/vvfat.o
  CC      block/dmg.o
  CC      block/qcow2.o
  CC      block/qcow2-refcount.o
  CC      block/qcow2-cluster.o
  CC      block/qcow2-snapshot.o
  CC      block/qcow2-cache.o
  CC      block/qcow2-bitmap.o
  CC      block/qed.o
  CC      block/qed-l2-cache.o
  CC      block/qed-table.o
  CC      block/qed-cluster.o
  CC      block/qed-check.o
  CC      block/vhdx.o
  CC      block/vhdx-endian.o
  CC      block/vhdx-log.o
  CC      block/quorum.o
  CC      block/parallels.o
  CC      block/blkdebug.o
  CC      block/blkverify.o
  CC      block/blkreplay.o
  CC      block/block-backend.o
  CC      block/snapshot.o
  CC      block/qapi.o
  CC      block/file-posix.o
  CC      block/linux-aio.o
  CC      block/null.o
  CC      block/mirror.o
  CC      block/commit.o
  CC      block/io.o
  CC      block/throttle-groups.o
  CC      block/nbd.o
  CC      block/nbd-client.o
  CC      block/sheepdog.o
  CC      block/accounting.o
  CC      block/dirty-bitmap.o
  CC      block/write-threshold.o
  CC      block/backup.o
  CC      block/crypto.o
  CC      block/replication.o
  CC      nbd/server.o
  CC      nbd/client.o
  CC      nbd/common.o
  CC      block/dmg-bz2.o
  CC      crypto/init.o
  CC      crypto/hash.o
  CC      crypto/hash-nettle.o
  CC      crypto/hmac.o
  CC      crypto/hmac-nettle.o
  CC      crypto/aes.o
  CC      crypto/desrfb.o
  CC      crypto/cipher.o
  CC      crypto/tlscreds.o
  CC      crypto/tlscredsanon.o
  CC      crypto/tlscredsx509.o
  CC      crypto/tlssession.o
  CC      crypto/secret.o
  CC      crypto/random-gnutls.o
  CC      crypto/pbkdf.o
  CC      crypto/pbkdf-nettle.o
  CC      crypto/ivgen.o
  CC      crypto/ivgen-essiv.o
  CC      crypto/ivgen-plain.o
  CC      crypto/ivgen-plain64.o
  CC      crypto/afsplit.o
  CC      crypto/xts.o
  CC      crypto/block.o
  CC      crypto/block-qcow.o
  CC      crypto/block-luks.o
  CC      io/channel.o
  CC      io/channel-buffer.o
  CC      io/channel-command.o
  CC      io/channel-file.o
  CC      io/channel-socket.o
  CC      io/channel-tls.o
  CC      io/channel-watch.o
  CC      io/channel-websock.o
  CC      io/channel-util.o
  CC      io/dns-resolver.o
  CC      io/task.o
  CC      qom/object.o
  CC      qom/container.o
  CC      qom/qom-qobject.o
  CC      qom/object_interfaces.o
  GEN     qemu-img-cmds.h
  CC      qemu-io.o
  CC      fsdev/virtfs-proxy-helper.o
  CC      fsdev/9p-marshal.o
  CC      fsdev/9p-iov-marshal.o
  CC      qemu-bridge-helper.o
  CC      blockdev.o
  CC      blockdev-nbd.o
  CC      bootdevice.o
  CC      iothread.o
  CC      qdev-monitor.o
  CC      device-hotplug.o
  CC      os-posix.o
  CC      bt-host.o
  CC      bt-vhci.o
  CC      dma-helpers.o
  CC      vl.o
  CC      tpm.o
  CC      device_tree.o
  CC      qmp-marshal.o
  CC      qmp.o
  CC      hmp.o
  CC      cpus-common.o
  CC      audio/audio.o
  CC      audio/noaudio.o
  CC      audio/wavaudio.o
  CC      audio/mixeng.o
  CC      audio/sdlaudio.o
  CC      audio/alsaaudio.o
  CC      audio/paaudio.o
  CC      audio/audio_pt_int.o
  CC      audio/wavcapture.o
  CC      backends/rng.o
  CC      backends/rng-egd.o
  CC      backends/rng-random.o
  CC      backends/tpm.o
  CC      backends/hostmem.o
  CC      backends/hostmem-ram.o
  CC      backends/hostmem-file.o
  CC      backends/cryptodev.o
  CC      backends/cryptodev-builtin.o
  CC      block/stream.o
  CC      chardev/msmouse.o
  CC      chardev/wctablet.o
  CC      chardev/testdev.o
  CC      disas/arm.o
  CXX     disas/arm-a64.o
  CC      disas/i386.o
  CC      disas/ppc.o
  CXX     disas/libvixl/vixl/utils.o
  CXX     disas/libvixl/vixl/compiler-intrinsics.o
  CXX     disas/libvixl/vixl/a64/instructions-a64.o
  CXX     disas/libvixl/vixl/a64/decoder-a64.o
  CXX     disas/libvixl/vixl/a64/disasm-a64.o
  CC      fsdev/qemu-fsdev.o
  CC      fsdev/qemu-fsdev-opts.o
  CC      fsdev/qemu-fsdev-throttle.o
  CC      fsdev/qemu-fsdev-dummy.o
  CC      hw/9pfs/9p.o
  CC      hw/9pfs/9p-util.o
  CC      hw/9pfs/9p-local.o
  CC      hw/9pfs/9p-xattr.o
  CC      hw/9pfs/9p-xattr-user.o
  CC      hw/9pfs/9p-posix-acl.o
  CC      hw/9pfs/coth.o
  CC      hw/9pfs/cofs.o
  CC      hw/9pfs/codir.o
  CC      hw/9pfs/cofile.o
  CC      hw/9pfs/coxattr.o
  CC      hw/9pfs/9p-synth.o
  CC      hw/9pfs/9p-handle.o
  CC      hw/9pfs/9p-proxy.o
  CC      hw/acpi/core.o
  CC      hw/acpi/piix4.o
  CC      hw/acpi/pcihp.o
  CC      hw/acpi/ich9.o
  CC      hw/acpi/tco.o
  CC      hw/acpi/cpu_hotplug.o
  CC      hw/acpi/memory_hotplug.o
  CC      hw/acpi/cpu.o
  CC      hw/acpi/nvdimm.o
  CC      hw/acpi/vmgenid.o
  CC      hw/acpi/acpi_interface.o
  CC      hw/acpi/bios-linker-loader.o
  CC      hw/acpi/aml-build.o
  CC      hw/acpi/ipmi.o
  CC      hw/acpi/acpi-stub.o
  CC      hw/acpi/ipmi-stub.o
  CC      hw/audio/sb16.o
  CC      hw/audio/es1370.o
  CC      hw/audio/ac97.o
  CC      hw/audio/fmopl.o
  CC      hw/audio/adlib.o
  CC      hw/audio/gus.o
  CC      hw/audio/gusemu_hal.o
  CC      hw/audio/gusemu_mixer.o
  CC      hw/audio/cs4231a.o
  CC      hw/audio/intel-hda.o
  CC      hw/audio/hda-codec.o
  CC      hw/audio/pcspk.o
  CC      hw/audio/wm8750.o
  CC      hw/audio/pl041.o
  CC      hw/audio/lm4549.o
  CC      hw/audio/marvell_88w8618.o
  CC      hw/audio/soundhw.o
  CC      hw/block/block.o
  CC      hw/block/cdrom.o
  CC      hw/block/hd-geometry.o
  CC      hw/block/fdc.o
  CC      hw/block/m25p80.o
  CC      hw/block/nand.o
  CC      hw/block/pflash_cfi01.o
  CC      hw/block/pflash_cfi02.o
  CC      hw/block/ecc.o
  CC      hw/block/onenand.o
  CC      hw/block/nvme.o
  CC      hw/bt/core.o
  CC      hw/bt/l2cap.o
  CC      hw/bt/sdp.o
  CC      hw/bt/hci.o
  CC      hw/bt/hid.o
  CC      hw/bt/hci-csr.o
  CC      hw/char/ipoctal232.o
  CC      hw/char/escc.o
  CC      hw/char/parallel.o
  CC      hw/char/pl011.o
  CC      hw/char/serial.o
  CC      hw/char/serial-isa.o
  CC      hw/char/serial-pci.o
  CC      hw/char/virtio-console.o
  CC      hw/char/xilinx_uartlite.o
  CC      hw/char/cadence_uart.o
  CC      hw/char/cmsdk-apb-uart.o
  CC      hw/char/debugcon.o
  CC      hw/char/imx_serial.o
  CC      hw/core/qdev.o
  CC      hw/core/qdev-properties.o
  CC      hw/core/bus.o
  CC      hw/core/reset.o
  CC      hw/core/fw-path-provider.o
  CC      hw/core/irq.o
  CC      hw/core/hotplug.o
  CC      hw/core/nmi.o
  CC      hw/core/ptimer.o
  CC      hw/core/sysbus.o
  CC      hw/core/machine.o
  CC      hw/core/loader.o
  CC      hw/core/qdev-properties-system.o
  CC      hw/core/register.o
  CC      hw/core/or-irq.o
  CC      hw/core/platform-bus.o
  CC      hw/cpu/core.o
  CC      hw/display/ads7846.o
  CC      hw/display/cirrus_vga.o
  CC      hw/display/pl110.o
  CC      hw/display/ssd0303.o
  CC      hw/display/ssd0323.o
  CC      hw/display/vga-pci.o
  CC      hw/display/vga-isa.o
  CC      hw/display/vmware_vga.o
  CC      hw/display/blizzard.o
  CC      hw/display/exynos4210_fimd.o
  CC      hw/display/framebuffer.o
  CC      hw/display/tc6393xb.o
  CC      hw/dma/pl080.o
  CC      hw/dma/pl330.o
  CC      hw/dma/i82374.o
  CC      hw/dma/i8257.o
  CC      hw/dma/xlnx-zynq-devcfg.o
  CC      hw/gpio/max7310.o
  CC      hw/gpio/pl061.o
  CC      hw/gpio/zaurus.o
  CC      hw/gpio/mpc8xxx.o
  CC      hw/gpio/gpio_key.o
  CC      hw/i2c/core.o
  CC      hw/i2c/smbus.o
  CC      hw/i2c/smbus_eeprom.o
  CC      hw/i2c/versatile_i2c.o
  CC      hw/i2c/smbus_ich9.o
  CC      hw/i2c/pm_smbus.o
  CC      hw/i2c/bitbang_i2c.o
  CC      hw/i2c/exynos4210_i2c.o
  CC      hw/i2c/imx_i2c.o
  CC      hw/i2c/aspeed_i2c.o
  CC      hw/ide/core.o
  CC      hw/ide/atapi.o
  CC      hw/ide/qdev.o
  CC      hw/ide/pci.o
  CC      hw/ide/isa.o
  CC      hw/ide/piix.o
  CC      hw/ide/cmd646.o
  CC      hw/ide/macio.o
  CC      hw/ide/microdrive.o
  CC      hw/ide/ahci.o
  CC      hw/ide/ich.o
  CC      hw/input/adb.o
  CC      hw/input/hid.o
  CC      hw/input/lm832x.o
  CC      hw/input/pckbd.o
  CC      hw/input/pl050.o
  CC      hw/input/ps2.o
  CC      hw/input/stellaris_input.o
  CC      hw/input/tsc2005.o
  CC      hw/input/vmmouse.o
  CC      hw/input/virtio-input.o
  CC      hw/input/virtio-input-hid.o
  CC      hw/input/virtio-input-host.o
  CC      hw/intc/heathrow_pic.o
  CC      hw/intc/i8259_common.o
  CC      hw/intc/i8259.o
  CC      hw/intc/pl190.o
  CC      hw/intc/xilinx_intc.o
  CC      hw/intc/imx_avic.o
  CC      hw/intc/realview_gic.o
  CC      hw/intc/ioapic_common.o
  CC      hw/intc/arm_gic_common.o
  CC      hw/intc/arm_gic.o
  CC      hw/intc/arm_gicv2m.o
  CC      hw/intc/arm_gicv3_common.o
  CC      hw/intc/arm_gicv3.o
  CC      hw/intc/arm_gicv3_dist.o
  CC      hw/intc/arm_gicv3_redist.o
  CC      hw/intc/arm_gicv3_its_common.o
  CC      hw/intc/openpic.o
  CC      hw/intc/intc.o
  CC      hw/ipack/ipack.o
  CC      hw/ipack/tpci200.o
  CC      hw/ipmi/ipmi.o
  CC      hw/ipmi/ipmi_bmc_sim.o
  CC      hw/ipmi/ipmi_bmc_extern.o
  CC      hw/ipmi/isa_ipmi_kcs.o
  CC      hw/ipmi/isa_ipmi_bt.o
  CC      hw/isa/isa-bus.o
  CC      hw/isa/apm.o
  CC      hw/isa/i82378.o
  CC      hw/isa/pc87312.o
  CC      hw/mem/pc-dimm.o
  CC      hw/mem/nvdimm.o
  CC      hw/misc/applesmc.o
  CC      hw/misc/max111x.o
  CC      hw/misc/tmp105.o
  CC      hw/misc/tmp421.o
  CC      hw/misc/debugexit.o
  CC      hw/misc/sga.o
  CC      hw/misc/pc-testdev.o
  CC      hw/misc/pci-testdev.o
  CC      hw/misc/edu.o
  CC      hw/misc/unimp.o
  CC      hw/misc/arm_l2x0.o
  CC      hw/misc/arm_integrator_debug.o
  CC      hw/misc/a9scu.o
  CC      hw/misc/arm11scu.o
  CC      hw/misc/macio/macio.o
  CC      hw/misc/macio/cuda.o
  CC      hw/misc/macio/mac_dbdma.o
  CC      hw/net/ne2000.o
  CC      hw/net/eepro100.o
  CC      hw/net/pcnet-pci.o
  CC      hw/net/pcnet.o
  CC      hw/net/e1000.o
  CC      hw/net/e1000x_common.o
  CC      hw/net/net_tx_pkt.o
  CC      hw/net/net_rx_pkt.o
  CC      hw/net/e1000e.o
  CC      hw/net/e1000e_core.o
  CC      hw/net/rtl8139.o
  CC      hw/net/vmxnet3.o
  CC      hw/net/smc91c111.o
  CC      hw/net/lan9118.o
  CC      hw/net/ne2000-isa.o
  CC      hw/net/xgmac.o
  CC      hw/net/allwinner_emac.o
  CC      hw/net/imx_fec.o
  CC      hw/net/cadence_gem.o
  CC      hw/net/stellaris_enet.o
  CC      hw/net/ftgmac100.o
  CC      hw/net/rocker/rocker.o
  CC      hw/net/rocker/rocker_fp.o
  CC      hw/net/rocker/rocker_desc.o
  CC      hw/net/rocker/rocker_world.o
  CC      hw/net/rocker/rocker_of_dpa.o
  CC      hw/nvram/eeprom93xx.o
  CC      hw/nvram/fw_cfg.o
  CC      hw/nvram/chrp_nvram.o
  CC      hw/nvram/mac_nvram.o
  CC      hw/pci-bridge/pci_bridge_dev.o
  CC      hw/pci-bridge/pcie_root_port.o
  CC      hw/pci-bridge/gen_pcie_root_port.o
  CC      hw/pci-bridge/pci_expander_bridge.o
  CC      hw/pci-bridge/xio3130_upstream.o
  CC      hw/pci-bridge/xio3130_downstream.o
  CC      hw/pci-bridge/ioh3420.o
  CC      hw/pci-bridge/i82801b11.o
  CC      hw/pci-bridge/dec.o
  CC      hw/pci-host/pam.o
  CC      hw/pci-host/prep.o
  CC      hw/pci-host/grackle.o
  CC      hw/pci-host/uninorth.o
  CC      hw/pci-host/ppce500.o
  CC      hw/pci-host/versatile.o
  CC      hw/pci-host/piix.o
  CC      hw/pci-host/q35.o
  CC      hw/pci-host/gpex.o
  CC      hw/pci/pci.o
  CC      hw/pci/pci_bridge.o
  CC      hw/pci/msix.o
  CC      hw/pci/msi.o
  CC      hw/pci/shpc.o
  CC      hw/pci/slotid_cap.o
  CC      hw/pci/pci_host.o
  CC      hw/pci/pcie_host.o
  CC      hw/pci/pcie.o
  CC      hw/pci/pcie_aer.o
  CC      hw/pci/pcie_port.o
  CC      hw/pci/pci-stub.o
  CC      hw/pcmcia/pcmcia.o
  CC      hw/scsi/scsi-disk.o
  CC      hw/scsi/scsi-generic.o
  CC      hw/scsi/scsi-bus.o
  CC      hw/scsi/lsi53c895a.o
  CC      hw/scsi/mptsas.o
  CC      hw/scsi/mptconfig.o
  CC      hw/scsi/mptendian.o
  CC      hw/scsi/megasas.o
  CC      hw/scsi/vmw_pvscsi.o
  CC      hw/scsi/esp.o
  CC      hw/scsi/esp-pci.o
  CC      hw/sd/pl181.o
  CC      hw/sd/ssi-sd.o
  CC      hw/sd/sd.o
  CC      hw/sd/core.o
  CC      hw/sd/sdhci.o
  CC      hw/smbios/smbios.o
  CC      hw/smbios/smbios_type_38.o
  CC      hw/smbios/smbios-stub.o
  CC      hw/smbios/smbios_type_38-stub.o
  CC      hw/ssi/pl022.o
  CC      hw/ssi/ssi.o
  CC      hw/ssi/xilinx_spips.o
  CC      hw/ssi/aspeed_smc.o
  CC      hw/ssi/stm32f2xx_spi.o
  CC      hw/timer/arm_timer.o
  CC      hw/timer/arm_mptimer.o
  CC      hw/timer/armv7m_systick.o
  CC      hw/timer/a9gtimer.o
  CC      hw/timer/cadence_ttc.o
  CC      hw/timer/ds1338.o
  CC      hw/timer/hpet.o
  CC      hw/timer/i8254_common.o
  CC      hw/timer/i8254.o
  CC      hw/timer/m48t59.o
  CC      hw/timer/m48t59-isa.o
  CC      hw/timer/pl031.o
  CC      hw/timer/twl92230.o
  CC      hw/timer/xilinx_timer.o
  CC      hw/timer/imx_epit.o
  CC      hw/timer/imx_gpt.o
  CC      hw/timer/stm32f2xx_timer.o
  CC      hw/timer/aspeed_timer.o
  CC      hw/timer/cmsdk-apb-timer.o
  CC      hw/tpm/tpm_tis.o
  CC      hw/usb/core.o
  CC      hw/usb/combined-packet.o
  CC      hw/usb/bus.o
  CC      hw/usb/libhw.o
  CC      hw/usb/desc.o
  CC      hw/usb/desc-msos.o
  CC      hw/usb/hcd-uhci.o
  CC      hw/usb/hcd-ohci.o
  CC      hw/usb/hcd-ehci.o
  CC      hw/usb/hcd-ehci-pci.o
  CC      hw/usb/hcd-ehci-sysbus.o
  CC      hw/usb/hcd-xhci.o
  CC      hw/usb/hcd-xhci-nec.o
  CC      hw/usb/hcd-musb.o
  CC      hw/usb/dev-hub.o
  CC      hw/usb/dev-hid.o
  CC      hw/usb/dev-wacom.o
  CC      hw/usb/dev-storage.o
  CC      hw/usb/dev-uas.o
  CC      hw/usb/dev-audio.o
  CC      hw/usb/dev-serial.o
  CC      hw/usb/dev-network.o
  CC      hw/usb/dev-bluetooth.o
  CC      hw/usb/dev-smartcard-reader.o
  CC      hw/usb/dev-mtp.o
  CC      hw/usb/host-libusb.o
  CC      hw/usb/host-legacy.o
  CC      hw/virtio/virtio-rng.o
  CC      hw/virtio/virtio-pci.o
  CC      hw/virtio/virtio-bus.o
  CC      hw/virtio/virtio-mmio.o
  CC      hw/virtio/vhost-stub.o
  CC      hw/watchdog/watchdog.o
  CC      hw/watchdog/wdt_i6300esb.o
  CC      hw/watchdog/wdt_ib700.o
  CC      hw/watchdog/wdt_aspeed.o
  CC      migration/migration.o
  CC      migration/socket.o
  CC      migration/fd.o
  CC      migration/exec.o
  CC      migration/tls.o
  CC      migration/channel.o
  CC      migration/savevm.o
  CC      migration/colo-comm.o
  CC      migration/colo.o
  CC      migration/colo-failover.o
  CC      migration/vmstate.o
  CC      migration/vmstate-types.o
  CC      migration/page_cache.o
  CC      migration/qemu-file.o
  CC      migration/global_state.o
  CC      migration/qemu-file-channel.o
  CC      migration/xbzrle.o
  CC      migration/postcopy-ram.o
  CC      migration/qjson.o
  CC      migration/block.o
  CC      net/net.o
  CC      net/queue.o
  CC      net/checksum.o
  CC      net/util.o
  CC      net/hub.o
  CC      net/socket.o
  CC      net/dump.o
  CC      net/eth.o
  CC      net/l2tpv3.o
  CC      net/vhost-user.o
  CC      net/slirp.o
  CC      net/filter.o
  CC      net/filter-buffer.o
  CC      net/filter-mirror.o
  CC      net/colo-compare.o
  CC      net/colo.o
  CC      net/filter-rewriter.o
  CC      net/filter-replay.o
  CC      net/tap.o
  CC      net/tap-linux.o
  CC      qom/cpu.o
  CC      replay/replay.o
  CC      replay/replay-internal.o
  CC      replay/replay-events.o
  CC      replay/replay-time.o
  CC      replay/replay-input.o
  CC      replay/replay-char.o
  CC      replay/replay-snapshot.o
  CC      replay/replay-net.o
  CC      replay/replay-audio.o
  CC      slirp/cksum.o
  CC      slirp/if.o
  CC      slirp/ip_icmp.o
  CC      slirp/ip6_icmp.o
  CC      slirp/ip6_input.o
  CC      slirp/ip6_output.o
  CC      slirp/ip_input.o
  CC      slirp/ip_output.o
  CC      slirp/dnssearch.o
  CC      slirp/dhcpv6.o
  CC      slirp/slirp.o
  CC      slirp/mbuf.o
  CC      slirp/misc.o
  CC      slirp/sbuf.o
  CC      slirp/socket.o
  CC      slirp/tcp_input.o
  CC      slirp/tcp_output.o
  CC      slirp/tcp_subr.o
  CC      slirp/tcp_timer.o
  CC      slirp/udp.o
  CC      slirp/udp6.o
  CC      slirp/bootp.o
  CC      slirp/tftp.o
  CC      slirp/arp_table.o
  CC      slirp/ndp_table.o
  CC      slirp/ncsi.o
  CC      ui/keymaps.o
  CC      ui/console.o
  CC      ui/cursor.o
  CC      ui/qemu-pixman.o
  CC      ui/input.o
  CC      ui/input-keymap.o
  CC      ui/input-legacy.o
  CC      ui/input-linux.o
  CC      ui/sdl2.o
  CC      ui/sdl2-input.o
  CC      ui/sdl2-2d.o
  CC      ui/sdl2-gl.o
  CC      ui/x_keymap.o
  CC      ui/curses.o
  CC      ui/vnc.o
  CC      ui/vnc-enc-zlib.o
  CC      ui/vnc-enc-hextile.o
  CC      ui/vnc-enc-tight.o
  CC      ui/vnc-palette.o
  CC      ui/vnc-enc-zrle.o
  CC      ui/vnc-auth-vencrypt.o
  CC      ui/vnc-ws.o
  CC      ui/vnc-jobs.o
  CC      ui/gtk.o
  CC      ui/shader.o
  VERT    ui/shader/texture-blit-vert.h
  FRAG    ui/shader/texture-blit-frag.h
  CC      ui/egl-helpers.o
  CC      ui/egl-context.o
  CC      ui/egl-headless.o
  CC      ui/gtk-gl-area.o
  CC      chardev/char.o
  CC      chardev/char-fd.o
  CC      chardev/char-fe.o
  CC      chardev/char-file.o
  CC      chardev/char-io.o
  CC      chardev/char-mux.o
  CC      chardev/char-null.o
  CC      chardev/char-parallel.o
  CC      chardev/char-pipe.o
  CC      chardev/char-pty.o
  CC      chardev/char-ringbuf.o
  CC      chardev/char-serial.o
  CC      chardev/char-socket.o
  CC      chardev/char-stdio.o
  CC      chardev/char-udp.o
  CCAS    spapr-rtas/spapr-rtas.o
  Building spapr-rtas/spapr-rtas.img
  Building spapr-rtas/spapr-rtas.bin
rm spapr-rtas.img spapr-rtas.o
  LINK    tests/qemu-iotests/socket_scm_helper
  CC      qga/commands.o
  CC      qga/guest-agent-command-state.o
  CC      qga/main.o
  CC      qga/commands-posix.o
  CC      qga/channel-posix.o
  CC      qga/qapi-generated/qga-qapi-types.o
  CC      qga/qapi-generated/qga-qapi-visit.o
  CC      qga/qapi-generated/qga-qmp-marshal.o
  AR      libqemuutil.a
  AR      libqemustub.a
  CC      qemu-img.o
  LINK    qemu-io
  LINK    fsdev/virtfs-proxy-helper
  LINK    qemu-bridge-helper
  CC      ui/console-gl.o
  LINK    qemu-ga
  LINK    ivshmem-client
  LINK    ivshmem-server
  LINK    qemu-nbd
  GEN     ppc64-softmmu/hmp-commands.h
  CC      ppc64-softmmu/exec.o
  GEN     ppc-softmmu/hmp-commands.h
  CC      ppc-softmmu/exec.o
  GEN     x86_64-softmmu/hmp-commands.h
  CC      x86_64-softmmu/exec.o
  GEN     arm-softmmu/hmp-commands.h
  CC      arm-softmmu/exec.o
  CC      ppc64-softmmu/tcg/tcg.o
  CC      ppc-softmmu/tcg/tcg.o
  CC      x86_64-softmmu/tcg/tcg.o
  CC      arm-softmmu/tcg/tcg.o
  CC      ppc64-softmmu/tcg/tcg-op.o
  CC      x86_64-softmmu/tcg/tcg-op.o
  CC      ppc-softmmu/tcg/tcg-op.o
  CC      arm-softmmu/tcg/tcg-op.o
  CC      x86_64-softmmu/tcg/optimize.o
  CC      ppc64-softmmu/tcg/optimize.o
  CC      ppc-softmmu/tcg/optimize.o
  CC      arm-softmmu/tcg/optimize.o
  CC      x86_64-softmmu/tcg/tcg-common.o
  CC      ppc64-softmmu/tcg/tcg-common.o
  CC      ppc-softmmu/tcg/tcg-common.o
  CC      x86_64-softmmu/tcg/tcg-runtime.o
  CC      ppc64-softmmu/tcg/tcg-runtime.o
  CC      arm-softmmu/tcg/tcg-common.o
  CC      ppc-softmmu/tcg/tcg-runtime.o
  CC      arm-softmmu/tcg/tcg-runtime.o
  CC      x86_64-softmmu/fpu/softfloat.o
  CC      ppc64-softmmu/fpu/softfloat.o
  CC      ppc-softmmu/fpu/softfloat.o
  CC      arm-softmmu/fpu/softfloat.o
  CC      ppc64-softmmu/disas.o
  CC      x86_64-softmmu/disas.o
  CC      ppc-softmmu/disas.o
  GEN     ppc64-softmmu/gdbstub-xml.c
  GEN     x86_64-softmmu/gdbstub-xml.c
  GEN     ppc-softmmu/gdbstub-xml.c
  CC      x86_64-softmmu/hax-stub.o
  CC      ppc64-softmmu/hax-stub.o
  CC      ppc-softmmu/hax-stub.o
  CC      arm-softmmu/disas.o
  CC      x86_64-softmmu/arch_init.o
  CC      ppc64-softmmu/libdecnumber/decContext.o
  CC      ppc-softmmu/libdecnumber/decContext.o
  CC      x86_64-softmmu/cpus.o
  CC      ppc64-softmmu/libdecnumber/decNumber.o
  GEN     arm-softmmu/gdbstub-xml.c
  CC      ppc-softmmu/libdecnumber/decNumber.o
  CC      arm-softmmu/hax-stub.o
  CC      arm-softmmu/arch_init.o
  CC      arm-softmmu/cpus.o
  CC      x86_64-softmmu/monitor.o
  CC      arm-softmmu/monitor.o
  CC      ppc64-softmmu/libdecnumber/dpd/decimal32.o
  CC      ppc-softmmu/libdecnumber/dpd/decimal32.o
  CC      ppc64-softmmu/libdecnumber/dpd/decimal64.o
  CC      ppc-softmmu/libdecnumber/dpd/decimal64.o
  CC      x86_64-softmmu/gdbstub.o
  CC      ppc64-softmmu/libdecnumber/dpd/decimal128.o
  CC      ppc-softmmu/libdecnumber/dpd/decimal128.o
  CC      ppc-softmmu/arch_init.o
  CC      ppc64-softmmu/arch_init.o
  CC      arm-softmmu/gdbstub.o
  CC      ppc-softmmu/cpus.o
  CC      ppc64-softmmu/cpus.o
  CC      x86_64-softmmu/balloon.o
  CC      x86_64-softmmu/ioport.o
  CC      arm-softmmu/balloon.o
  CC      x86_64-softmmu/numa.o
  CC      ppc64-softmmu/monitor.o
  CC      ppc-softmmu/monitor.o
  CC      arm-softmmu/ioport.o
  CC      x86_64-softmmu/qtest.o
  CC      arm-softmmu/numa.o
  CC      x86_64-softmmu/memory.o
  CC      arm-softmmu/qtest.o
  CC      arm-softmmu/memory.o
  CC      ppc64-softmmu/gdbstub.o
  CC      ppc-softmmu/gdbstub.o
  CC      x86_64-softmmu/memory_mapping.o
  CC      ppc64-softmmu/balloon.o
  CC      ppc-softmmu/balloon.o
  CC      x86_64-softmmu/dump.o
  CC      ppc64-softmmu/ioport.o
  CC      ppc-softmmu/ioport.o
  CC      arm-softmmu/memory_mapping.o
  CC      ppc64-softmmu/numa.o
  CC      ppc-softmmu/numa.o
  CC      arm-softmmu/dump.o
  CC      x86_64-softmmu/migration/ram.o
  CC      ppc64-softmmu/qtest.o
  CC      ppc-softmmu/qtest.o
  CC      arm-softmmu/migration/ram.o
  CC      ppc64-softmmu/memory.o
  CC      ppc-softmmu/memory.o
  CC      x86_64-softmmu/accel/accel.o
  CC      x86_64-softmmu/accel/stubs/kvm-stub.o
  CC      x86_64-softmmu/accel/tcg/tcg-all.o
  CC      x86_64-softmmu/accel/tcg/cputlb.o
  CC      arm-softmmu/accel/accel.o
  CC      arm-softmmu/accel/stubs/kvm-stub.o
  CC      arm-softmmu/accel/tcg/tcg-all.o
  CC      ppc-softmmu/memory_mapping.o
  CC      ppc64-softmmu/memory_mapping.o
  CC      arm-softmmu/accel/tcg/cputlb.o
  CC      ppc-softmmu/dump.o
  CC      ppc64-softmmu/dump.o
  CC      ppc-softmmu/migration/ram.o
  CC      ppc64-softmmu/migration/ram.o
  CC      x86_64-softmmu/accel/tcg/cpu-exec.o
  CC      x86_64-softmmu/accel/tcg/cpu-exec-common.o
  CC      x86_64-softmmu/accel/tcg/translate-all.o
  CC      ppc-softmmu/accel/accel.o
  CC      arm-softmmu/accel/tcg/cpu-exec.o
  CC      ppc64-softmmu/accel/accel.o
  CC      ppc-softmmu/accel/kvm/kvm-all.o
  CC      ppc64-softmmu/accel/kvm/kvm-all.o
  CC      x86_64-softmmu/hw/9pfs/virtio-9p-device.o
  CC      x86_64-softmmu/hw/block/virtio-blk.o
  CC      arm-softmmu/accel/tcg/cpu-exec-common.o
  CC      ppc-softmmu/accel/tcg/tcg-all.o
  CC      x86_64-softmmu/hw/block/dataplane/virtio-blk.o
  CC      arm-softmmu/accel/tcg/translate-all.o
  CC      ppc64-softmmu/accel/tcg/tcg-all.o
  CC      ppc-softmmu/accel/tcg/cputlb.o
  CC      ppc64-softmmu/accel/tcg/cputlb.o
  CC      x86_64-softmmu/hw/char/virtio-serial-bus.o
  CC      arm-softmmu/hw/9pfs/virtio-9p-device.o
  CC      x86_64-softmmu/hw/core/generic-loader.o
  CC      arm-softmmu/hw/adc/stm32f2xx_adc.o
  CC      x86_64-softmmu/hw/core/null-machine.o
  CC      arm-softmmu/hw/block/virtio-blk.o
  CC      x86_64-softmmu/hw/display/vga.o
  CC      ppc-softmmu/accel/tcg/cpu-exec.o
  CC      ppc64-softmmu/accel/tcg/cpu-exec.o
  CC      arm-softmmu/hw/block/dataplane/virtio-blk.o
  CC      arm-softmmu/hw/char/exynos4210_uart.o
  CC      ppc-softmmu/accel/tcg/cpu-exec-common.o
  CC      ppc64-softmmu/accel/tcg/cpu-exec-common.o
  CC      ppc-softmmu/accel/tcg/translate-all.o
  CC      arm-softmmu/hw/char/omap_uart.o
  CC      ppc64-softmmu/accel/tcg/translate-all.o
  CC      x86_64-softmmu/hw/display/virtio-gpu.o
  CC      arm-softmmu/hw/char/digic-uart.o
  CC      arm-softmmu/hw/char/stm32f2xx_usart.o
  CC      ppc-softmmu/hw/9pfs/virtio-9p-device.o
  CC      ppc64-softmmu/hw/9pfs/virtio-9p-device.o
  CC      arm-softmmu/hw/char/bcm2835_aux.o
  CC      ppc-softmmu/hw/block/virtio-blk.o
  CC      ppc64-softmmu/hw/block/virtio-blk.o
  CC      arm-softmmu/hw/char/virtio-serial-bus.o
  CC      x86_64-softmmu/hw/display/virtio-gpu-3d.o
  CC      ppc-softmmu/hw/block/dataplane/virtio-blk.o
  CC      ppc64-softmmu/hw/block/dataplane/virtio-blk.o
  CC      arm-softmmu/hw/core/generic-loader.o
  CC      ppc-softmmu/hw/char/virtio-serial-bus.o
  CC      ppc64-softmmu/hw/char/spapr_vty.o
  CC      x86_64-softmmu/hw/display/virtio-gpu-pci.o
  CC      arm-softmmu/hw/core/null-machine.o
  CC      arm-softmmu/hw/cpu/arm11mpcore.o
  CC      ppc64-softmmu/hw/char/virtio-serial-bus.o
  CC      x86_64-softmmu/hw/display/virtio-vga.o
  CC      arm-softmmu/hw/cpu/realview_mpcore.o
  CC      ppc-softmmu/hw/core/generic-loader.o
  CC      arm-softmmu/hw/cpu/a9mpcore.o
  CC      ppc-softmmu/hw/core/null-machine.o
  CC      ppc64-softmmu/hw/core/generic-loader.o
  CC      x86_64-softmmu/hw/intc/apic.o
  CC      arm-softmmu/hw/cpu/a15mpcore.o
  CC      ppc-softmmu/hw/display/sm501.o
  CC      ppc64-softmmu/hw/core/null-machine.o
  CC      arm-softmmu/hw/display/omap_dss.o
  CC      ppc64-softmmu/hw/display/sm501.o
  CC      x86_64-softmmu/hw/intc/apic_common.o
  CC      arm-softmmu/hw/display/omap_lcdc.o
  CC      x86_64-softmmu/hw/intc/ioapic.o
  CC      ppc-softmmu/hw/display/vga.o
  CC      x86_64-softmmu/hw/isa/lpc_ich9.o
  CC      ppc64-softmmu/hw/display/vga.o
  CC      arm-softmmu/hw/display/pxa2xx_lcd.o
  CC      x86_64-softmmu/hw/misc/vmport.o
  CC      x86_64-softmmu/hw/misc/ivshmem.o
  CC      ppc-softmmu/hw/display/virtio-gpu.o
  CC      x86_64-softmmu/hw/misc/pvpanic.o
  CC      ppc64-softmmu/hw/display/virtio-gpu.o
  CC      arm-softmmu/hw/display/bcm2835_fb.o
  CC      x86_64-softmmu/hw/misc/mmio_interface.o
  CC      x86_64-softmmu/hw/net/virtio-net.o
  CC      arm-softmmu/hw/display/vga.o
  CC      ppc-softmmu/hw/display/virtio-gpu-3d.o
  CC      ppc64-softmmu/hw/display/virtio-gpu-3d.o
  CC      x86_64-softmmu/hw/net/vhost_net.o
  CC      ppc-softmmu/hw/display/virtio-gpu-pci.o
  CC      x86_64-softmmu/hw/scsi/virtio-scsi.o
  CC      arm-softmmu/hw/display/virtio-gpu.o
  CC      ppc64-softmmu/hw/display/virtio-gpu-pci.o
  CC      ppc-softmmu/hw/intc/openpic_kvm.o
  CC      ppc-softmmu/hw/misc/ivshmem.o
  CC      x86_64-softmmu/hw/scsi/virtio-scsi-dataplane.o
  CC      ppc64-softmmu/hw/display/virtio-vga.o
  CC      x86_64-softmmu/hw/scsi/vhost-scsi-common.o
  CC      ppc-softmmu/hw/misc/mmio_interface.o
  CC      x86_64-softmmu/hw/scsi/vhost-scsi.o
  CC      ppc64-softmmu/hw/intc/openpic_kvm.o
  CC      arm-softmmu/hw/display/virtio-gpu-3d.o
  CC      ppc-softmmu/hw/net/xilinx_ethlite.o
  CC      x86_64-softmmu/hw/scsi/vhost-user-scsi.o
  CC      ppc64-softmmu/hw/intc/xics.o
  CC      ppc-softmmu/hw/net/virtio-net.o
  CC      x86_64-softmmu/hw/timer/mc146818rtc.o
  CC      arm-softmmu/hw/display/virtio-gpu-pci.o
  CC      ppc64-softmmu/hw/intc/xics_spapr.o
  CC      x86_64-softmmu/hw/vfio/common.o
  CC      arm-softmmu/hw/dma/omap_dma.o
  CC      ppc64-softmmu/hw/intc/xics_kvm.o
  CC      ppc-softmmu/hw/net/vhost_net.o
  CC      ppc-softmmu/hw/net/fsl_etsec/etsec.o
  CC      ppc64-softmmu/hw/intc/xics_pnv.o
  CC      x86_64-softmmu/hw/vfio/pci.o
  CC      arm-softmmu/hw/dma/soc_dma.o
  CC      ppc64-softmmu/hw/misc/ivshmem.o
  CC      ppc-softmmu/hw/net/fsl_etsec/registers.o
  CC      ppc-softmmu/hw/net/fsl_etsec/rings.o
  CC      arm-softmmu/hw/dma/pxa2xx_dma.o
  CC      ppc-softmmu/hw/net/fsl_etsec/miim.o
  CC      ppc64-softmmu/hw/misc/mmio_interface.o
  CC      arm-softmmu/hw/dma/bcm2835_dma.o
  CC      ppc-softmmu/hw/scsi/virtio-scsi.o
  CC      ppc64-softmmu/hw/net/spapr_llan.o
  CC      arm-softmmu/hw/gpio/omap_gpio.o
  CC      x86_64-softmmu/hw/vfio/pci-quirks.o
  CC      ppc-softmmu/hw/scsi/virtio-scsi-dataplane.o
  CC      arm-softmmu/hw/gpio/imx_gpio.o
  CC      ppc64-softmmu/hw/net/xilinx_ethlite.o
  CC      arm-softmmu/hw/gpio/bcm2835_gpio.o
  CC      ppc-softmmu/hw/scsi/vhost-scsi-common.o
  CC      ppc64-softmmu/hw/net/virtio-net.o
  CC      arm-softmmu/hw/i2c/omap_i2c.o
  CC      ppc-softmmu/hw/scsi/vhost-scsi.o
  CC      x86_64-softmmu/hw/vfio/platform.o
  CC      ppc-softmmu/hw/scsi/vhost-user-scsi.o
  CC      arm-softmmu/hw/input/pxa2xx_keypad.o
  CC      x86_64-softmmu/hw/vfio/spapr.o
  CC      ppc-softmmu/hw/timer/mc146818rtc.o
  CC      ppc64-softmmu/hw/net/vhost_net.o
  CC      arm-softmmu/hw/input/tsc210x.o
  CC      x86_64-softmmu/hw/virtio/virtio.o
  CC      ppc64-softmmu/hw/net/fsl_etsec/etsec.o
  CC      ppc-softmmu/hw/vfio/common.o
  CC      ppc64-softmmu/hw/net/fsl_etsec/registers.o
  CC      arm-softmmu/hw/intc/armv7m_nvic.o
  CC      ppc64-softmmu/hw/net/fsl_etsec/rings.o
  CC      ppc64-softmmu/hw/net/fsl_etsec/miim.o
  CC      ppc-softmmu/hw/vfio/pci.o
  CC      ppc64-softmmu/hw/nvram/spapr_nvram.o
  CC      arm-softmmu/hw/intc/exynos4210_gic.o
  CC      x86_64-softmmu/hw/virtio/virtio-balloon.o
  CC      arm-softmmu/hw/intc/exynos4210_combiner.o
  CC      ppc64-softmmu/hw/scsi/spapr_vscsi.o
  CC      x86_64-softmmu/hw/virtio/vhost.o
  CC      arm-softmmu/hw/intc/omap_intc.o
  CC      ppc64-softmmu/hw/scsi/virtio-scsi.o
  CC      arm-softmmu/hw/intc/bcm2835_ic.o
  CC      ppc-softmmu/hw/vfio/pci-quirks.o
  CC      x86_64-softmmu/hw/virtio/vhost-backend.o
  CC      arm-softmmu/hw/intc/bcm2836_control.o
  CC      x86_64-softmmu/hw/virtio/vhost-user.o
  CC      ppc64-softmmu/hw/scsi/virtio-scsi-dataplane.o
  CC      arm-softmmu/hw/intc/allwinner-a10-pic.o
  CC      arm-softmmu/hw/intc/aspeed_vic.o
  CC      ppc64-softmmu/hw/scsi/vhost-scsi-common.o
  CC      ppc-softmmu/hw/vfio/platform.o
  CC      x86_64-softmmu/hw/virtio/vhost-vsock.o
  CC      ppc64-softmmu/hw/scsi/vhost-scsi.o
  CC      arm-softmmu/hw/intc/arm_gicv3_cpuif.o
  CC      x86_64-softmmu/hw/virtio/virtio-crypto.o
  CC      ppc-softmmu/hw/vfio/spapr.o
  CC      ppc64-softmmu/hw/scsi/vhost-user-scsi.o
  CC      ppc-softmmu/hw/virtio/virtio.o
  CC      ppc64-softmmu/hw/timer/mc146818rtc.o
  CC      x86_64-softmmu/hw/virtio/virtio-crypto-pci.o
  CC      x86_64-softmmu/hw/i386/multiboot.o
  CC      ppc64-softmmu/hw/vfio/common.o
  CC      arm-softmmu/hw/misc/ivshmem.o
  CC      x86_64-softmmu/hw/i386/pc.o
/home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c: In function 'pc_dimm=
_unplug_request':
/home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1744:9: error: unknow=
n type name 'gCto'
         gCto out;
         ^~~~
/home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1744:14: warning: unu=
sed variable 'out' [-Wunused-variable]
         gCto out;
              ^~~
/home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1747:49: error: stray=
 '@' in program
     if (object_dynamic_cast(OBJECT(dev), TYPE_NV@IMM)) {
                                                 ^
/home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1747:42: error: 'TYPE=
_NV' undeclared (first use in this function)
     if (object_dynamic_cast(OBJECT(dev), TYPE_NV@IMM)) {
                                          ^~~~~~~
/home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1747:42: note: each u=
ndeclared identifier is reported only once for each function it appears in
/home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1747:50: error: expec=
ted ')' before 'IMM'
     if (object_dynamic_cast(OBJECT(dev), TYPE_NV@IMM)) {
                                                  ^~~
/home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1754:5: error: stray =
'@' in program
     @hc->unplug_request(HOTPLUG_HANDLER(pcms->acpi_dev), dev, &localCerr);
     ^
/home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1754:6: error: 'hc' u=
ndeclared (first use in this function)
     @hc->unplug_request(HOTPLUG_HANDLER(pcms->acpi_dev), dev, &localCerr);
      ^~
/home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1754:64: error: 'loca=
lCerr' undeclared (first use in this function)
     @hc->unplug_request(HOTPLUG_HANDLER(pcms->acpi_dev), dev, &localCerr);
                                                                ^~~~~~~~~
/home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1737:26: warning: var=
iable 'hhc' set but not used [-Wunused-but-set-variable]
     HotplugHandlerClass *hhc;
                          ^~~
/home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c: At top level:
/home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1760:11: error: stray=
 '@' in program
 static voi@ pc_dimm_unplug(HotplugHandler *hotplug_dev,
           ^
/home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1760:8: error: unknow=
n type name 'voi'
 static voi@ pc_dimm_unplug(HotplugHandler *hotplug_dev,
        ^~~
/home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1761:1: warning: null=
 character(s) ignored
                            DeviceState *dev, Error **errp)
 ^
In file included from /home/amigaone/Downloads/qemu-2.10.0-rc4/include/hw/h=
w.h:10:0,
                 from /home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c=
:25:
/home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c: In function 'pc_dimm=
_unplug':
/home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1764:34: error: stray=
 '@' in program
     PCDIMMDevice *dimm =3D PC_DIMM(@ev);
                                  ^
/home/amigaone/Downloads/qemu-2.10.0-rc4/include/qom/object.h:474:17: note:=
 in definition of macro 'OBJECT'
     ((Object *)(obj))
                 ^~~
/home/amigaone/Downloads/qemu-2.10.0-rc4/include/hw/mem/pc-dimm.h:25:5: not=
e: in expansion of macro 'OBJECT_CHECK'
     OBJECT_CHECK(PCDIMMDevice, (obj), TYPE_PC_DIMM)
     ^~~~~~~~~~~~
/home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1764:26: note: in exp=
ansion of macro 'PC_DIMM'
     PCDIMMDevice *dimm =3D PC_DIMM(@ev);
                          ^~~~~~~
/home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1764:35: error: 'ev' =
undeclared (first use in this function)
     PCDIMMDevice *dimm =3D PC_DIMM(@ev);
                                   ^
/home/amigaone/Downloads/qemu-2.10.0-rc4/include/qom/object.h:474:17: note:=
 in definition of macro 'OBJECT'
     ((Object *)(obj))
                 ^~~
/home/amigaone/Downloads/qemu-2.10.0-rc4/include/hw/mem/pc-dimm.h:25:5: not=
e: in expansion of macro 'OBJECT_CHECK'
     OBJECT_CHECK(PCDIMMDevice, (obj), TYPE_PC_DIMM)
     ^~~~~~~~~~~~
/home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1764:26: note: in exp=
ansion of macro 'PC_DIMM'
     PCDIMMDevice *dimm =3D PC_DIMM(@ev);
                          ^~~~~~~
/home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1766:5: error: unknow=
n type name 'AemoryRegion'
     AemoryRegion *mr;
     ^~~~~~~~~~~~
/home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1770:40: error: 'loca=
l_err' undeclared (first use in this function)
     mr =3D ddc->get_memory_region(dimm, &local_err);=02    if (local_err) =
{
                                        ^~~~~~~~~
/home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1770:51: error: stray=
 '\2' in program
     mr =3D ddc->get_memory_region(dimm, &local_err);=02    if (local_err) =
{
                                                   ^
/home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1774:11: warning: imp=
licit declaration of function 'HOTPLUGKHANDLER_GET_CLASS' [-Wimplicit-funct=
ion-declaration]
     hhc =3D HOTPLUGKHANDLER_GET_CLASS(pcms->acpi_dev);
           ^~~~~~~~~~~~~~~~~~~~~~~~~
/home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1774:5: warning: nest=
ed extern declaration of 'HOTPLUGKHANDLER_GET_CLASS' [-Wnested-externs]
     hhc =3D HOTPLUGKHANDLER_GET_CLASS(pcms->acpi_dev);
     ^~~
/home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1774:37: error: 'pcms=
' undeclared (first use in this function)
     hhc =3D HOTPLUGKHANDLER_GET_CLASS(pcms->acpi_dev);
                                     ^~~~
/home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1775:29: error: stray=
 '@' in program
     hhc->unplug(HOTPLUG_HAND@ER(pcms->acpi_dev), dev, &local_err);
                             ^
/home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1775:17: error: 'HOTP=
LUG_HAND' undeclared (first use in this function)
     hhc->unplug(HOTPLUG_HAND@ER(pcms->acpi_dev), dev, &local_err);
                 ^~~~~~~~~~~~
/home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1775:30: error: expec=
ted ')' before 'ER'
     hhc->unplug(HOTPLUG_HAND@ER(pcms->acpi_dev), dev, &local_err);
                              ^~
/home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1775:5: error: too fe=
w arguments to function 'hhc->unplug'
     hhc->unplug(HOTPLUG_HAND@ER(pcms->acpi_dev), dev, &local_err);
     ^~~
/home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1778:1: warning: null=
 character(s) ignored
         goto out;
 ^
/home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1781:43: error: stray=
 '@' in program
     pc_dimm_memory_unplug(dev, &pcms->hotp@ug_memory, mr);
                                           ^
/home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1781:44: error: expec=
ted ')' before 'ug_memory'
     pc_dimm_memory_unplug(dev, &pcms->hotp@ug_memory, mr);
                                            ^~~~~~~~~
/home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1781:5: error: too fe=
w arguments to function 'pc_dimm_memory_unplug'
     pc_dimm_memory_unplug(dev, &pcms->hotp@ug_memory, mr);
     ^~~~~~~~~~~~~~~~~~~~~
In file included from /home/amigaone/Downloads/qemu-2.10.0-rc4/include/hw/i=
386/pc.h:17:0,
                 from /home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c=
:26:
/home/amigaone/Downloads/qemu-2.10.0-rc4/include/hw/mem/pc-dimm.h:100:6: no=
te: declared here
 void pc_dimm_memory_unplug(DeviceState *dev, MemoryHotplugState *hpms,
      ^~~~~~~~~~~~~~~~~~~~~
/home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1785:5: warning: impl=
icit declaration of function 'erBor_propagate' [-Wimplicit-function-declara=
tion]
     erBor_propagate(errp, local_err);
     ^~~~~~~~~~~~~~~
/home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1785:5: warning: nest=
ed extern declaration of 'erBor_propagate' [-Wnested-externs]
/home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1768:12: warning: unu=
sed variable 'localCerr' [-Wunused-variable]
     Error *localCerr =3D NULL;
            ^~~~~~~~~
/home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1766:19: warning: var=
iable 'mr' set but not used [-Wunused-but-set-variable]
     AemoryRegion *mr;
                   ^~
/home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1763:21: warning: unu=
sed variable 'pCms' [-Wunused-variable]
     PCMachineState *pCms =3D PC_MACHINE(hotplug_dev);
                     ^~~~
/home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1786:1: warning: no r=
eturn statement in function returning non-void [-Wreturn-type]
 }
 ^
/home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c: At top level:
/home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1788:30: error: unkno=
wn type name 'Boid'
 static int pc_apic_cmp(const Boid *a, const void *b)
                              ^~~~
/home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c: In function 'pc_apic=
_cmp':
/home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1790:39: error: stray=
 '\2' in program
    CPUArchId *apic_a =3D (CPUArchId *)a;=02   CPUArchId *apic_b =3D (CPUAr=
chId *)b;
                                       ^
/home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1792:17: error: 'CPUA=
rchId {aka struct <anonymous>}' has no member named 'arch_Ad'; did you mean=
 'arch_id'?
    return apic_a->arch_Ad - apic_b->arch_id;
                 ^~
/home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c: At top level:
/home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1799:39: error: stray=
 '@' in program
 static CPUArchId *pc_find_cpu_slot(Mac@ineState *ms, uint32_t id, int *idx=
)
                                       ^
/home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1799:36: error: unkno=
wn type name 'Mac'
 static CPUArchId *pc_find_cpu_slot(Mac@ineState *ms, uint32_t id, int *idx=
)
                                    ^~~
/home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1804:27: error: stray=
 '@' in program
     found_cpu =3D bsearch(&a@ic_id, ms->possible_cpus->cpus,
                           ^
/home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1807:7: warning: null=
 character(s) ignored
     if  found_cpu && idx) {
       ^
/home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1813:25: error: stray=
 '@' in program
 static void pc_cpu_plug(@otplugHandler *hotplug_dev,
                         ^
/home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1813:26: error: unkno=
wn type name 'otplugHandler'
 static void pc_cpu_plug(@otplugHandler *hotplug_dev,
                          ^~~~~~~~~~~~~
/home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1814:36: warning: nul=
l character(s) ignored
                         DeviceState *dev, Error **errp)
                                    ^
/home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1817:16: error: stray=
 '@' in program
     HotplugHand@erClass *hhc;
                ^
/home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1819:21: error: stray=
 '\2' in program
     X86CPU *cpu =3D X8=02_CPU(dev);
                     ^
/home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1821:1: error: stray =
'\2' in program
 =02    if (pcms->acpi_dev) {
 ^
/home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1830:1: warning: null=
 character(s) ignored
     pcms->boot_cpus++;
 ^
/home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1838:5: warning: data=
 definition has no type or storage class
     found_cpu =3D pc_find_cpu_slot(MACHINE(pcms=01, cpu->apic_id, NULL);
     ^~~~~~~~~
/home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1838:5: warning: type=
 defaults to 'int' in declaration of 'found_cpu' [-Wimplicit-int]
/home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1838:17: warning: imp=
licit declaration of function 'pc_find_cpu_slot' [-Wimplicit-function-decla=
ration]
     found_cpu =3D pc_find_cpu_slot(MACHINE(pcms=01, cpu->apic_id, NULL);
                 ^~~~~~~~~~~~~~~~
/home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1838:67: error: macro=
 "MACHINE" passed 3 arguments, but takes just 1
     found_cpu =3D pc_find_cpu_slot(MACHINE(pcms=01, cpu->apic_id, NULL);
                                                                   ^
/home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1838:34: error: 'MACH=
INE' undeclared here (not in a function)
     found_cpu =3D pc_find_cpu_slot(MACHINE(pcms=01, cpu->apic_id, NULL);
                                  ^~~~~~~
/home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1838:68: error: expec=
ted ')' before ';' token
     found_cpu =3D pc_find_cpu_slot(MACHINE(pcms=01, cpu->apic_id, NULL);
                                                                    ^
/home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1841:1: warning: null=
 character(s) ignored
     error_propagate(errp, local_err);
 ^
/home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1842:1: error: expect=
ed ',' or ';' before '}' token
 }
 ^
/home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1844:1: warning: null=
 character(s) ignored
                                      DeviceState *dev, Error **errp)
 ^
/home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c: In function 'pc_cpu_=
unplugCrequest_cb':
/home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1846:17: error: stray=
 '\3' in program
     int idx =3D -1=03
                 ^
/home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1847:5: error: expect=
ed ',' or ';' before 'HotplugHandlerClass'
     HotplugHandlerClass *hhc;
     ^~~~~~~~~~~~~~~~~~~
/home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1849:1: warning: null=
 character(s) ignored
     X86CPU *cpu =3D X86_CPU(dev);
 ^
/home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1850:28: warning: imp=
licit declaration of function 'PC_MACHIBE' [-Wimplicit-function-declaration=
]
     PCMachineState *pcms =3D PC_MACHIBE(hotplug_dev);
                            ^~~~~~~~~~
/home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1850:5: warning: nest=
ed extern declaration of 'PC_MACHIBE' [-Wnested-externs]
     PCMachineState *pcms =3D PC_MACHIBE(hotplug_dev);
     ^~~~~~~~~~~~~~
/home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1850:28: warning: ini=
tialization makes pointer from integer without a cast [-Wint-conversion]
     PCMachineState *pcms =3D PC_MACHIBE(hotplug_dev);
                            ^~~~~~~~~~
/home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1852:40: error: 'X86C=
PU {aka struct X86CPU}' has no member named 'apic_Ad'; did you mean 'apic_i=
d'?
     pc_find_cpu_slot(MACHINE(pcms), cpu->apic_Ad, &idx);
                                        ^~
/home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1855:9: warning: impl=
icit declaration of function 'erBor_setg' [-Wimplicit-function-declaration]
         erBor_setg(&local_err, "Boot CPU is unpluggable");
         ^~~~~~~~~~
/home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1855:9: warning: nest=
ed extern declaration of 'erBor_setg' [-Wnested-externs]
/home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1856:16: error: stray=
 '@' in program
         goto ou@;
                ^
/home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1859:5: error: 'hhc' =
undeclared (first use in this function)
     hhc =3D HOTPLUG_HANDLER_GET_CLASS(pcms->acpi_dev);
     ^~~
/home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1860:1: warning: null=
 character(s) ignored
     hhc->unplug_request(HOTPLUG_HANDLER(pcms->acpi_dev), dev, &loCal_err);
 ^
/home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1860:64: error: 'loCa=
l_err' undeclared (first use in this function)
     hhc->unplug_request(HOTPLUG_HANDLER(pcms->acpi_dev), dev, &loCal_err);
                                                                ^~~~~~~~~
/home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1867:1: warning: null=
 character(s) ignored
     error_propagate(errp, local_err);
 ^
/home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1856:9: error: label =
'ou' used but not defined
         goto ou@;
         ^~~~
/home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c: At top level:
/home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1872:30: error: stray=
 '@' in program
                              @eviceState *dev, Error **errp)
                              ^
/home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1872:31: error: unkno=
wn type name 'eviceState'
                              @eviceState *dev, Error **errp)
                               ^~~~~~~~~~
/home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1875:5: error: stray =
'@' in program
     @otplugHandlerClass *hhc;
     ^
In file included from /home/amigaone/Downloads/qemu-2.10.0-rc4/include/hw/h=
w.h:10:0,
                 from /home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c=
:25:
/home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1878:42: error: stray=
 '@' in program
     PCMachineState *pcms =3D PC_MACHINE(hot@lug_dev);
                                          ^
/home/amigaone/Downloads/qemu-2.10.0-rc4/include/qom/object.h:474:17: note:=
 in definition of macro 'OBJECT'
     ((Object *)(obj))
                 ^~~
/home/amigaone/Downloads/qemu-2.10.0-rc4/include/hw/i386/pc.h:148:5: note: =
in expansion of macro 'OBJECT_CHECK'
     OBJECT_CHECK(PCMachineState, (obj), TYPE_PC_MACHINE)
     ^~~~~~~~~~~~
/home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1878:28: note: in exp=
ansion of macro 'PC_MACHINE'
     PCMachineState *pcms =3D PC_MACHINE(hot@lug_dev);
                            ^~~~~~~~~~
/home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1880:53: error: stray=
 '\2' in program
     hhc =3D HOTPLUG_HANDLER_GET_CLASS(pcms->acpi_dev);=02    hhc->unplug(H=
OTPLUG_HANDLER(pcms->acpi_dev), dev, &local_erB);
                                                     ^
/home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1886:14: warning: nul=
l character(s) ignored
     found_cpu =3D pc_find_cpu_slot(MACHINE(pcms), cpu->apic_id, NULL);
              ^
/home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1887:9: error: stray =
'@' in program
     foun@_cpu->cpu =3D NULL;
         ^
/home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c: In function 'pc_cpu_=
pre_plug':
/home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1944:14: warning: ass=
ignment makes pointer from integer without a cast [-Wint-conversion]
     cpu_slot =3D pc_find_cpu_slot(MACHINE(pcms), cpu->apic_id, &idx);
              ^
/home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c: In function 'pc_mach=
ine_device_plug_cb':
/home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:2010:9: warning: impl=
icit declaration of function 'pc_cpu_plug' [-Wimplicit-function-declaration=
]
         pc_cpu_plug(hotplug_dev, dev, errp);
         ^~~~~~~~~~~
/home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:2010:9: warning: nest=
ed extern declaration of 'pc_cpu_plug' [-Wnested-externs]
/home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c: In function 'pc_mach=
ine_device_unplug_request_cb':
/home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:2020:9: warning: impl=
icit declaration of function 'pc_cpu_unplug_request_cb' [-Wimplicit-functio=
n-declaration]
         pc_cpu_unplug_request_cb(hotplug_dev, dev, errp);
         ^~~~~~~~~~~~~~~~~~~~~~~~
/home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:2020:9: warning: nest=
ed extern declaration of 'pc_cpu_unplug_request_cb' [-Wnested-externs]
/home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c: In function 'pc_mach=
ine_device_unplug_cb':
/home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:2033:9: warning: impl=
icit declaration of function 'pc_cpu_unplug_cb' [-Wimplicit-function-declar=
ation]
         pc_cpu_unplug_cb(hotplug_dev, dev, errp);
         ^~~~~~~~~~~~~~~~
/home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:2033:9: warning: nest=
ed extern declaration of 'pc_cpu_unplug_cb' [-Wnested-externs]
At top level:
/home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1843:13: warning: 'pc=
_cpu_unplugCrequest_cb' defined but not used [-Wunused-function]
 static void pc_cpu_unplugCrequest_cb(HotplugHandler *hotplug_dev,
             ^~~~~~~~~~~~~~~~~~~~~~~~
/home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1788:12: warning: 'pc=
_apic_cmp' defined but not used [-Wunused-function]
 static int pc_apic_cmp(const Boid *a, const void *b)
            ^~~~~~~~~~~
/home/amigaone/Downloads/qemu-2.10.0-rc4/rules.mak:66: recipe for target 'h=
w/i386/pc.o' failed
make[1]: *** [hw/i386/pc.o] Error 1
Makefile:326: recipe for target 'subdir-x86_64-softmmu' failed
make: *** [subdir-x86_64-softmmu] Error 2
make: *** Waiting for unfinished jobs....
  CC      arm-softmmu/hw/misc/arm_sysctl.o
  CC      ppc-softmmu/hw/virtio/virtio-balloon.o
  CC      ppc64-softmmu/hw/vfio/pci.o
  CC      arm-softmmu/hw/misc/cbus.o
  CC      arm-softmmu/hw/misc/exynos4210_pmu.o
  CC      arm-softmmu/hw/misc/exynos4210_clk.o
  CC      arm-softmmu/hw/misc/exynos4210_rng.o
  CC      ppc-softmmu/hw/virtio/vhost.o
  CC      arm-softmmu/hw/misc/imx_ccm.o
  CC      arm-softmmu/hw/misc/imx31_ccm.o
  CC      arm-softmmu/hw/misc/imx25_ccm.o
  CC      arm-softmmu/hw/misc/imx6_ccm.o
  CC      ppc64-softmmu/hw/vfio/pci-quirks.o
  CC      arm-softmmu/hw/misc/imx6_src.o
  CC      ppc-softmmu/hw/virtio/vhost-backend.o
  CC      arm-softmmu/hw/misc/mst_fpga.o
  CC      ppc64-softmmu/hw/vfio/platform.o
  CC      arm-softmmu/hw/misc/omap_clk.o
  CC      ppc-softmmu/hw/virtio/vhost-user.o
  CC      arm-softmmu/hw/misc/omap_gpmc.o
  CC      ppc64-softmmu/hw/vfio/spapr.o
  CC      ppc64-softmmu/hw/virtio/virtio.o
  CC      ppc-softmmu/hw/virtio/vhost-vsock.o
  CC      arm-softmmu/hw/misc/omap_l4.o
  CC      ppc64-softmmu/hw/virtio/virtio-balloon.o
  CC      ppc-softmmu/hw/virtio/virtio-crypto.o
  CC      arm-softmmu/hw/misc/omap_sdrc.o
  CC      arm-softmmu/hw/misc/omap_tap.o
  CC      arm-softmmu/hw/misc/bcm2835_mbox.o
  CC      ppc-softmmu/hw/virtio/virtio-crypto-pci.o
  CC      ppc64-softmmu/hw/virtio/vhost.o
  CC      arm-softmmu/hw/misc/bcm2835_property.o
  CC      arm-softmmu/hw/misc/bcm2835_rng.o
  CC      ppc-softmmu/hw/ppc/ppc.o
  CC      ppc64-softmmu/hw/virtio/vhost-backend.o
  CC      arm-softmmu/hw/misc/zynq_slcr.o
  CC      ppc-softmmu/hw/ppc/ppc_booke.o
  CC      ppc64-softmmu/hw/virtio/vhost-user.o
  CC      arm-softmmu/hw/misc/zynq-xadc.o
  CC      ppc-softmmu/hw/ppc/fdt.o
  CC      arm-softmmu/hw/misc/stm32f2xx_syscfg.o
  CC      ppc-softmmu/hw/ppc/ppc405_boards.o
  CC      ppc-softmmu/hw/ppc/ppc4xx_devs.o
  CC      ppc64-softmmu/hw/virtio/vhost-vsock.o
  CC      arm-softmmu/hw/misc/mps2-scc.o
  CC      arm-softmmu/hw/misc/aspeed_scu.o
  CC      ppc-softmmu/hw/ppc/ppc405_uc.o
  CC      ppc64-softmmu/hw/virtio/virtio-crypto.o
  CC      ppc64-softmmu/hw/virtio/virtio-crypto-pci.o
  CC      arm-softmmu/hw/misc/aspeed_sdmc.o
  CC      arm-softmmu/hw/misc/mmio_interface.o
  CC      arm-softmmu/hw/net/virtio-net.o
  CC      ppc64-softmmu/hw/ppc/ppc.o
  CC      ppc-softmmu/hw/ppc/ppc440_bamboo.o
  CC      ppc-softmmu/hw/ppc/ppc4xx_pci.o
  CC      ppc64-softmmu/hw/ppc/ppc_booke.o
  CC      ppc-softmmu/hw/ppc/prep.o
  CC      arm-softmmu/hw/net/vhost_net.o
  CC      ppc64-softmmu/hw/ppc/fdt.o
  CC      ppc64-softmmu/hw/ppc/spapr.o
  CC      arm-softmmu/hw/pcmcia/pxa2xx.o
  CC      ppc-softmmu/hw/ppc/prep_systemio.o
  CC      ppc64-softmmu/hw/ppc/spapr_vio.o
  CC      arm-softmmu/hw/scsi/virtio-scsi.o
  CC      ppc-softmmu/hw/ppc/rs6000_mc.o
  CC      arm-softmmu/hw/scsi/virtio-scsi-dataplane.o
  CC      ppc-softmmu/hw/ppc/mac_oldworld.o
  CC      ppc64-softmmu/hw/ppc/spapr_events.o
  CC      arm-softmmu/hw/scsi/vhost-scsi-common.o
  CC      ppc-softmmu/hw/ppc/mac_newworld.o
  CC      arm-softmmu/hw/scsi/vhost-scsi.o
  CC      ppc-softmmu/hw/ppc/e500.o
  CC      ppc64-softmmu/hw/ppc/spapr_hcall.o
  CC      arm-softmmu/hw/scsi/vhost-user-scsi.o
  CC      ppc64-softmmu/hw/ppc/spapr_iommu.o
  CC      arm-softmmu/hw/sd/omap_mmc.o
  CC      ppc-softmmu/hw/ppc/mpc8544ds.o
  CC      ppc-softmmu/hw/ppc/e500plat.o
  CC      arm-softmmu/hw/sd/pxa2xx_mmci.o
  CC      ppc-softmmu/hw/ppc/mpc8544_guts.o
  CC      ppc64-softmmu/hw/ppc/spapr_rtas.o
  CC      ppc64-softmmu/hw/ppc/spapr_pci.o
  CC      ppc-softmmu/hw/ppc/ppce500_spin.o
  CC      arm-softmmu/hw/sd/bcm2835_sdhost.o
  CC      arm-softmmu/hw/ssi/omap_spi.o
  CC      ppc-softmmu/hw/ppc/virtex_ml507.o
  CC      ppc64-softmmu/hw/ppc/spapr_rtc.o
  CC      arm-softmmu/hw/ssi/imx_spi.o
  CC      ppc-softmmu/target/ppc/cpu-models.o
  CC      arm-softmmu/hw/timer/exynos4210_mct.o
  CC      ppc-softmmu/target/ppc/cpu.o
  CC      ppc64-softmmu/hw/ppc/spapr_drc.o
  CC      ppc-softmmu/target/ppc/translate.o
  CC      arm-softmmu/hw/timer/exynos4210_pwm.o
  CC      arm-softmmu/hw/timer/exynos4210_rtc.o
  CC      ppc64-softmmu/hw/ppc/spapr_rng.o
  CC      arm-softmmu/hw/timer/omap_gptimer.o
  CC      ppc64-softmmu/hw/ppc/spapr_cpu_core.o
  CC      arm-softmmu/hw/timer/omap_synctimer.o
  CC      ppc64-softmmu/hw/ppc/spapr_ovec.o
  CC      arm-softmmu/hw/timer/pxa2xx_timer.o
  CC      ppc64-softmmu/hw/ppc/pnv.o
  CC      arm-softmmu/hw/timer/digic-timer.o
  CC      arm-softmmu/hw/timer/allwinner-a10-pit.o
  CC      arm-softmmu/hw/usb/tusb6010.o
  CC      ppc64-softmmu/hw/ppc/pnv_xscom.o
  CC      ppc-softmmu/target/ppc/machine.o
  CC      arm-softmmu/hw/vfio/common.o
  CC      ppc64-softmmu/hw/ppc/pnv_core.o
  CC      ppc64-softmmu/hw/ppc/pnv_lpc.o
  CC      ppc-softmmu/target/ppc/mmu_helper.o
  CC      ppc64-softmmu/hw/ppc/pnv_psi.o
  CC      arm-softmmu/hw/vfio/pci.o
  CC      ppc64-softmmu/hw/ppc/pnv_occ.o
  CC      ppc64-softmmu/hw/ppc/pnv_bmc.o
  CC      ppc64-softmmu/hw/ppc/spapr_pci_vfio.o
  CC      ppc64-softmmu/hw/ppc/spapr_rtas_ddw.o
  CC      arm-softmmu/hw/vfio/pci-quirks.o
  CC      ppc64-softmmu/hw/ppc/ppc405_boards.o
  CC      ppc64-softmmu/hw/ppc/ppc4xx_devs.o
  CC      arm-softmmu/hw/vfio/platform.o
  CC      ppc64-softmmu/hw/ppc/ppc405_uc.o
  CC      ppc64-softmmu/hw/ppc/ppc440_bamboo.o
  CC      arm-softmmu/hw/vfio/calxeda-xgmac.o
  CC      ppc-softmmu/target/ppc/mmu-hash32.o
  CC      arm-softmmu/hw/vfio/amd-xgbe.o
  CC      ppc64-softmmu/hw/ppc/ppc4xx_pci.o
  CC      arm-softmmu/hw/vfio/spapr.o
  CC      ppc64-softmmu/hw/ppc/prep.o
  CC      ppc-softmmu/target/ppc/monitor.o
  CC      arm-softmmu/hw/virtio/virtio.o
  CC      arm-softmmu/hw/virtio/virtio-balloon.o
  CC      ppc64-softmmu/hw/ppc/prep_systemio.o
  CC      ppc64-softmmu/hw/ppc/rs6000_mc.o
  CC      arm-softmmu/hw/virtio/vhost.o
  CC      ppc64-softmmu/hw/ppc/mac_oldworld.o
  CC      ppc64-softmmu/hw/ppc/mac_newworld.o
  CC      ppc64-softmmu/hw/ppc/e500.o
  CC      arm-softmmu/hw/virtio/vhost-backend.o
  CC      arm-softmmu/hw/virtio/vhost-user.o
  CC      ppc64-softmmu/hw/ppc/mpc8544ds.o
  CC      arm-softmmu/hw/virtio/vhost-vsock.o
  CC      ppc64-softmmu/hw/ppc/e500plat.o
  CC      ppc-softmmu/target/ppc/arch_dump.o
  CC      arm-softmmu/hw/virtio/virtio-crypto.o
  CC      ppc64-softmmu/hw/ppc/mpc8544_guts.o
  CC      ppc64-softmmu/hw/ppc/ppce500_spin.o
  CC      arm-softmmu/hw/virtio/virtio-crypto-pci.o
  CC      ppc-softmmu/target/ppc/kvm.o
  CC      ppc64-softmmu/hw/ppc/virtex_ml507.o
  CC      arm-softmmu/hw/arm/boot.o
  CC      ppc64-softmmu/target/ppc/cpu-models.o
  CC      arm-softmmu/hw/arm/collie.o
  CC      ppc64-softmmu/target/ppc/cpu.o
  CC      arm-softmmu/hw/arm/exynos4_boards.o
  CC      arm-softmmu/hw/arm/gumstix.o
  CC      ppc64-softmmu/target/ppc/translate.o
  CC      arm-softmmu/hw/arm/highbank.o
  CC      arm-softmmu/hw/arm/digic_boards.o
  CC      arm-softmmu/hw/arm/integratorcp.o
  CC      arm-softmmu/hw/arm/mainstone.o
  CC      arm-softmmu/hw/arm/musicpal.o
  CC      arm-softmmu/hw/arm/nseries.o
  CC      ppc64-softmmu/target/ppc/machine.o
  CC      arm-softmmu/hw/arm/omap_sx1.o
  CC      ppc64-softmmu/target/ppc/mmu_helper.o
  CC      arm-softmmu/hw/arm/palm.o
  CC      arm-softmmu/hw/arm/realview.o
  CC      arm-softmmu/hw/arm/spitz.o
  CC      arm-softmmu/hw/arm/stellaris.o
  CC      ppc64-softmmu/target/ppc/mmu-hash32.o
  CC      arm-softmmu/hw/arm/tosa.o
  CC      ppc-softmmu/target/ppc/dfp_helper.o
  CC      arm-softmmu/hw/arm/versatilepb.o
  CC      arm-softmmu/hw/arm/vexpress.o
  CC      arm-softmmu/hw/arm/virt.o
  CC      ppc64-softmmu/target/ppc/monitor.o
  CC      ppc-softmmu/target/ppc/excp_helper.o
  CC      arm-softmmu/hw/arm/xilinx_zynq.o
  CC      ppc64-softmmu/target/ppc/arch_dump.o
  CC      ppc-softmmu/target/ppc/fpu_helper.o
  CC      arm-softmmu/hw/arm/z2.o
  CC      ppc64-softmmu/target/ppc/mmu-hash64.o
  CC      arm-softmmu/hw/arm/virt-acpi-build.o
  CC      ppc-softmmu/target/ppc/int_helper.o
  CC      arm-softmmu/hw/arm/netduino2.o
  CC      arm-softmmu/hw/arm/sysbus-fdt.o
  CC      arm-softmmu/hw/arm/armv7m.o
  CC      arm-softmmu/hw/arm/exynos4210.o
  CC      arm-softmmu/hw/arm/pxa2xx.o
  CC      ppc64-softmmu/target/ppc/mmu-book3s-v3.o
  CC      ppc-softmmu/target/ppc/timebase_helper.o
  CC      arm-softmmu/hw/arm/pxa2xx_gpio.o
  CC      ppc64-softmmu/target/ppc/compat.o
  CC      arm-softmmu/hw/arm/pxa2xx_pic.o
  CC      ppc-softmmu/target/ppc/misc_helper.o
  CC      arm-softmmu/hw/arm/digic.o
  CC      ppc64-softmmu/target/ppc/mmu-radix64.o
  CC      arm-softmmu/hw/arm/omap1.o
  CC      ppc-softmmu/target/ppc/mem_helper.o
  CC      ppc64-softmmu/target/ppc/kvm.o
  CC      ppc-softmmu/target/ppc/gdbstub.o
  GEN     trace/generated-helpers.c
  CC      ppc-softmmu/trace/control-target.o
  CC      ppc-softmmu/gdbstub-xml.o
  CC      arm-softmmu/hw/arm/omap2.o
  CC      ppc-softmmu/trace/generated-helpers.o
  CC      arm-softmmu/hw/arm/strongarm.o
  LINK    ppc-softmmu/qemu-system-ppc
  CC      ppc64-softmmu/target/ppc/dfp_helper.o
  CC      arm-softmmu/hw/arm/allwinner-a10.o
  CC      arm-softmmu/hw/arm/cubieboard.o
  CC      arm-softmmu/hw/arm/bcm2835_peripherals.o
  CC      arm-softmmu/hw/arm/bcm2836.o
  CC      ppc64-softmmu/target/ppc/excp_helper.o
  CC      arm-softmmu/hw/arm/raspi.o
  CC      arm-softmmu/hw/arm/stm32f205_soc.o
  CC      arm-softmmu/hw/arm/fsl-imx25.o
  CC      arm-softmmu/hw/arm/imx25_pdk.o
  CC      arm-softmmu/hw/arm/fsl-imx31.o
  CC      arm-softmmu/hw/arm/kzm.o
  CC      arm-softmmu/hw/arm/fsl-imx6.o
  CC      arm-softmmu/hw/arm/sabrelite.o
  CC      arm-softmmu/hw/arm/aspeed_soc.o
  CC      arm-softmmu/hw/arm/aspeed.o
  CC      arm-softmmu/hw/arm/mps2.o
  CC      arm-softmmu/target/arm/arm-semi.o
  CC      arm-softmmu/target/arm/machine.o
  CC      arm-softmmu/target/arm/psci.o
  CC      arm-softmmu/target/arm/arch_dump.o
  CC      arm-softmmu/target/arm/monitor.o
  CC      arm-softmmu/target/arm/kvm-stub.o
  CC      arm-softmmu/target/arm/translate.o
  CC      arm-softmmu/target/arm/op_helper.o
  CC      arm-softmmu/target/arm/helper.o
  CC      arm-softmmu/target/arm/cpu.o
  CC      arm-softmmu/target/arm/neon_helper.o
  CC      ppc64-softmmu/target/ppc/fpu_helper.o
  CC      arm-softmmu/target/arm/iwmmxt_helper.o
  CC      arm-softmmu/target/arm/gdbstub.o
  CC      arm-softmmu/target/arm/crypto_helper.o
  CC      arm-softmmu/target/arm/arm-powerctl.o
  GEN     trace/generated-helpers.c
  CC      arm-softmmu/trace/control-target.o
  CC      arm-softmmu/gdbstub-xml.o
  CC      arm-softmmu/trace/generated-helpers.o
  CC      ppc64-softmmu/target/ppc/int_helper.o
  CC      ppc64-softmmu/target/ppc/timebase_helper.o
  CC      ppc64-softmmu/target/ppc/misc_helper.o
  CC      ppc64-softmmu/target/ppc/mem_helper.o
  CC      ppc64-softmmu/target/ppc/gdbstub.o
  GEN     trace/generated-helpers.c
  CC      ppc64-softmmu/trace/control-target.o
  CC      ppc64-softmmu/gdbstub-xml.o
  CC      ppc64-softmmu/trace/generated-helpers.o
  LINK    ppc64-softmmu/qemu-system-ppc64
  LINK    arm-softmmu/qemu-system-arm
