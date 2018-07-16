Received: from eggs.gnu.org ([2001:4830:134:3::10]:50068)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ff4x6-0006fn-H8
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 10:58:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ff4x3-00086H-Fg
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 10:58:16 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55212 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ff4x3-00086A-9j
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 10:58:13 -0400
References: <1529355846-25102-1-git-send-email-linux@roeck-us.net>
	<CAFEAcA9fvZbZGjm8Z5nJKi37J7Qma+bSFd0mRQ7tZ1X2NDRqQg@mail.gmail.com>
	<050c8913-5fb3-6044-c145-f83b1c02a6b7@roeck-us.net>
	<CAFEAcA-hDeys-yQaH9tCbDooH3-2T-jqVBX6=+QuS_Jenv1iNw@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d9fa4ed5-3d82-261e-111d-983cc766000d@redhat.com>
Date: Mon, 16 Jul 2018 16:58:10 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-hDeys-yQaH9tCbDooH3-2T-jqVBX6=+QuS_Jenv1iNw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] bcm2835_aux: Swap RX and TX interrupt
 assignments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Guenter Roeck <linux@roeck-us.net>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 16/07/2018 16:47, Peter Maydell wrote:
>> I didn't know that ;-). I found out the hard way.
> I'll take this through target-arm.next (I have some other patches
> for rc1 anyway) and adjust the commit message.
> 
> Paolo: you can drop it from your queue.

Done, thanks!

Paolo
