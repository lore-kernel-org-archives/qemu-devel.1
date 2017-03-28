Received: from eggs.gnu.org ([2001:4830:134:3::10]:36856)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cssrm-0003F9-CC
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 11:17:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cssri-0002zi-8f
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 11:17:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60530)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1cssri-0002z8-2Z
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 11:16:58 -0400
References: <d4c50e61-112c-1818-479e-494d58e361f2@ilande.co.uk>
	<CAFEAcA_vArTuWDGpTeToFhjfSV1BC3BV8WhjDsZtO5uxWiarMQ@mail.gmail.com>
	<d8a1ecfb-cce1-e855-9f0b-49dccd830155@weilnetz.de>
	<9e2591a0-4c25-5f00-0fd3-9c175bfbab12@ilande.co.uk>
	<25632d57-622c-e0b0-029a-28fdca0a427f@weilnetz.de>
	<360a7047-6190-c006-e155-1166ab14b83a@ilande.co.uk>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <e776dac5-ea72-efaf-c9d5-6b98f49e47e7@redhat.com>
Date: Tue, 28 Mar 2017 17:16:36 +0200
MIME-Version: 1.0
In-Reply-To: <360a7047-6190-c006-e155-1166ab14b83a@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Problems with native Mingw-w64 build
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Stefan Weil <sw@weilnetz.de>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>

On 28.03.2017 09:25, Mark Cave-Ayland wrote:
[...]
> I ended up starting again from scratch last night and trying the build
> with MSYS2 instead. MSYS2 has really improved since I last looked at it
> a couple of years back, and I was able to get a working build
> environment all set and working without any issues, i.e. set up the
> build environment, run configure, make and make install.
> 
> I did make a few notes during installation so if people think it's
> useful I can work through them again and come up with something suitable
> for the wiki.

We've already got a page with instructions for building with MingW:

 http://wiki.qemu-project.org/Hosts/W32

So that might be a good place to add your experience with MSYS, I guess?

 Thomas
