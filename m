Received: from eggs.gnu.org ([2001:4830:134:3::10]:37952)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vincenzo.romano@notorand.it>) id 1cMW6V-0003oN-Ip
	for qemu-devel@nongnu.org; Thu, 29 Dec 2016 03:30:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vincenzo.romano@notorand.it>) id 1cMW6U-0006zU-Oe
	for qemu-devel@nongnu.org; Thu, 29 Dec 2016 03:30:27 -0500
Received: from mail-lf0-x233.google.com ([2a00:1450:4010:c07::233]:36760)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <vincenzo.romano@notorand.it>)
	id 1cMW6U-0006yw-D5
	for qemu-devel@nongnu.org; Thu, 29 Dec 2016 03:30:26 -0500
Received: by mail-lf0-x233.google.com with SMTP id t196so217588194lff.3
	for <qemu-devel@nongnu.org>; Thu, 29 Dec 2016 00:30:24 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <A7AC9346-B5B0-44F1-9E24-54D14C6A5A55@gmail.com>
References: <A7AC9346-B5B0-44F1-9E24-54D14C6A5A55@gmail.com>
From: Vincenzo Romano <vincenzo.romano@notorand.it>
Date: Thu, 29 Dec 2016 09:30:22 +0100
Message-ID: <CAHjZ2x5+xeFyF549scdNu0UqetCkwaOHDU9ZnhwzOze+SUUSHw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [Qemu-discuss] Reducing guest cpu usage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Programmingkid <programmingkidx@gmail.com>
Cc: qemu-discuss <qemu-discuss@nongnu.org>, qemu-devel qemu-devel <qemu-devel@nongnu.org>

I think you have to provide much more details:
Qemu version
Host CPU and OS
Guest CPU and OS
Application details


Il 29 dic 2016 07:27, "Programmingkid" <programmingkidx@gmail.com> ha
scritto:

> There is a program that I run inside of QEMU that doesn't use the virtual
> CPU very efficiently. It causes QEMU to use 100% of the guest's CPU time. I
> was wondering if there were a way to reduce the amount of host CPU time
> that a guest CPU can use? This feature would help prevent laptops from
> heating up when running QEMU.
>
