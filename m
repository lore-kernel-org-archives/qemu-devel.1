Received: from eggs.gnu.org ([2001:4830:134:3::10]:41773)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fqgAo-0001nU-7Q
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 10:56:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fqgAi-0001g7-Bu
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 10:56:18 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:39899)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fqgAe-0001bo-Np
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 10:56:14 -0400
Received: by mail-oi0-x242.google.com with SMTP id d189-v6so14447561oib.6
	for <qemu-devel@nongnu.org>; Fri, 17 Aug 2018 07:56:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180723142224.11e912ec@redhat.com>
References: <20180704124923.32483-1-drjones@redhat.com>
	<20180704124923.32483-2-drjones@redhat.com>
	<20180723142224.11e912ec@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 17 Aug 2018 15:55:49 +0100
Message-ID: <CAFEAcA8QoaGLOVJn-JYQKsgfiLrqChXRP5wdAY3BwZHnz8ssZg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [RFC PATCH 1/6] hw/arm/virt: Add virt-3.1 machine
 type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Andrew Jones <drjones@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Eric Auger <eric.auger@redhat.com>, Wei Huang <wei@redhat.com>

On 23 July 2018 at 13:22, Igor Mammedov <imammedo@redhat.com> wrote:
> On Wed,  4 Jul 2018 14:49:18 +0200
> Andrew Jones <drjones@redhat.com> wrote:
>
>> Signed-off-by: Andrew Jones <drjones@redhat.com>
>
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>

We're going to want a virt-3.1 machine anyway, so I'm
going to take just this patch from this series and apply it
to target-arm.next.

thanks
-- PMM
