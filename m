Received: from eggs.gnu.org ([2001:4830:134:3::10]:55548)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <michael@walle.cc>) id 1dzMoz-0002O6-SR
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 09:01:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <michael@walle.cc>) id 1dzMoq-0004Ab-Nc
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 09:01:13 -0400
Received: from ssl.serverraum.org ([213.133.101.245]:37563)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <michael@walle.cc>) id 1dzMoq-00049V-Gk
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 09:01:04 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Tue, 03 Oct 2017 15:01:01 +0200
From: Michael Walle <michael@walle.cc>
In-Reply-To: <1506935300-132598-8-git-send-email-imammedo@redhat.com>
References: <1506935300-132598-1-git-send-email-imammedo@redhat.com>
	<1506935300-132598-8-git-send-email-imammedo@redhat.com>
Message-ID: <2798e9f6de374b429b8274bc273b5b5d@walle.cc>
Subject: Re: [Qemu-devel] [PATCH 07/38] lm32: milkymist: use generic
 cpu_model parsing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

Am 2017-10-02 11:07, schrieb Igor Mammedov:
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
> CC: michael@walle.cc
> ---
>  hw/lm32/milkymist.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 

Acked-by: Michael Walle <michael@walle.cc>
