Received: from eggs.gnu.org ([2001:4830:134:3::10]:33179)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1dvUJ9-0005Br-U9
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 16:12:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1dvUJ9-0005BC-54
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 16:12:19 -0400
References: <20170922154014.29350-1-f4bug@amsat.org>
	<20170922160111.31885-3-f4bug@amsat.org>
From: =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>
Message-ID: <0aa179bb-7d59-bd23-2969-34c42e3167bf@reactos.org>
Date: Fri, 22 Sep 2017 22:12:12 +0200
MIME-Version: 1.0
In-Reply-To: <20170922160111.31885-3-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 25/34] hw/timer/m48t59: use TYPE_M48T59_ISA,
 add entries to MAINTAINERS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-trivial@nongnu.org

Le 22/09/2017 à 18:01, Philippe Mathieu-Daudé a écrit :
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>   include/hw/timer/m48t59.h | 2 ++
>   hw/ppc/prep.c             | 2 +-
>   hw/timer/m48t59-isa.c     | 2 +-
>   MAINTAINERS               | 2 ++
>   4 files changed, 6 insertions(+), 2 deletions(-)

Reviewed-by: Hervé Poussineau <hpoussin@reactos.org>
