Received: from eggs.gnu.org ([2001:4830:134:3::10]:57870)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=449813866=anthony.perard@citrix.com>)
	id 1e23Wb-0007pu-EG
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 19:01:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=449813866=anthony.perard@citrix.com>)
	id 1e23Wa-0008K8-PN
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 19:01:21 -0400
Date: Tue, 10 Oct 2017 16:37:33 +0100
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20171010153733.GM1771@perard.uk.xensource.com>
References: <20170922154014.29350-1-f4bug@amsat.org>
	<20170922154014.29350-13-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170922154014.29350-13-f4bug@amsat.org>
Subject: Re: [Qemu-devel] [PATCH 12/34] misc: remove old i386 dependency
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org

On Fri, Sep 22, 2017 at 12:39:52PM -0300, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
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
> 

Reviewed-by: Anthony PERARD <anthony.perard@citrix.com>

-- 
Anthony PERARD
