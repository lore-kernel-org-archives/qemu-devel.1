Received: from eggs.gnu.org ([2001:4830:134:3::10]:34087)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1dvULB-0006u5-Al
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 16:14:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1dvULA-0006Tj-DM
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 16:14:25 -0400
References: <20170922154014.29350-1-f4bug@amsat.org>
	<20170922160111.31885-10-f4bug@amsat.org>
From: =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>
Message-ID: <812ae714-83b4-909e-544a-03844a33ddab@reactos.org>
Date: Fri, 22 Sep 2017 22:14:16 +0200
MIME-Version: 1.0
In-Reply-To: <20170922160111.31885-10-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 32/34] hw/net/ne2000: use TYPE_PCI_NE2000
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>, Jason Wang <jasowang@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-trivial@nongnu.org

Le 22/09/2017 à 18:01, Philippe Mathieu-Daudé a écrit :
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>   include/hw/net/pci.h  | 1 +
>   hw/net/ne2000.c       | 3 ++-
>   hw/ppc/mac_newworld.c | 3 ++-
>   hw/ppc/mac_oldworld.c | 3 ++-
>   hw/ppc/prep.c         | 2 +-
>   hw/sparc64/sun4u.c    | 3 ++-
>   6 files changed, 10 insertions(+), 5 deletions(-)

Reviewed-by: Hervé Poussineau <hpoussin@reactos.org>
