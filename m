Received: from eggs.gnu.org ([2001:4830:134:3::10]:43452)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <michael@walle.cc>) id 1dW2sr-00072S-QS
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 11:52:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <michael@walle.cc>) id 1dW2sn-0002NJ-RZ
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 11:52:01 -0400
Received: from ssl.serverraum.org ([213.133.101.245]:35928)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <michael@walle.cc>) id 1dW2sn-0002MK-G9
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 11:51:57 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Fri, 14 Jul 2017 17:51:53 +0200
From: Michael Walle <michael@walle.cc>
In-Reply-To: <1500040339-119465-25-git-send-email-imammedo@redhat.com>
References: <1500040339-119465-1-git-send-email-imammedo@redhat.com>
	<1500040339-119465-25-git-send-email-imammedo@redhat.com>
Message-ID: <7e33bf904c83e120b6814650dc049a08@walle.cc>
Subject: Re: [Qemu-devel] [PATCH 24/28] lm32: replace cpu_lm32_init() with
 cpu_generic_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, Eduardo Habkost <ehabkost@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

Am 2017-07-14 15:52, schrieb Igor Mammedov:
> it's just a wrapper, drop it and use cpu_generic_init() directly
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Acked-by: Michael Walle <michael@walle.cc>
