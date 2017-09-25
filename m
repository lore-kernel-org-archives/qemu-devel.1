Received: from eggs.gnu.org ([2001:4830:134:3::10]:41613)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dwLjv-0007iS-3C
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 01:15:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dwLjr-0003cV-Vo
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 01:15:31 -0400
References: <20170922154014.29350-1-f4bug@amsat.org>
	<20170922154014.29350-13-f4bug@amsat.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <4c218cec-26dc-4cc6-240a-347b2f5b973b@redhat.com>
Date: Mon, 25 Sep 2017 07:15:18 +0200
MIME-Version: 1.0
In-Reply-To: <20170922154014.29350-13-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 12/34] misc: remove old i386 dependency
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Anthony Perard <anthony.perard@citrix.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org

On 22.09.2017 17:39, Philippe Mathieu-Daud=C3=A9 wrote:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/audio/pcspk.c                    | 1 -
>  hw/i386/kvm/pci-assign.c            | 1 -
>  hw/i386/pci-assign-load-rom.c       | 1 -
>  hw/i386/xen/xen_platform.c          | 1 -
>  hw/isa/vt82c686.c                   | 1 -
>  hw/misc/ivshmem.c                   | 1 -
>  hw/misc/sga.c                       | 1 -
>  hw/pci-bridge/pci_expander_bridge.c | 1 -
>  monitor.c                           | 1 -
>  9 files changed, 9 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>
