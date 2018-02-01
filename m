Received: from eggs.gnu.org ([2001:4830:134:3::10]:32843)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1ehIR4-0001Cy-Vn
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 12:14:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1ehIR1-0002ba-JY
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 12:14:06 -0500
Received: from zero.eik.bme.hu ([152.66.115.2]:45113)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1ehIR1-0002aN-BF
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 12:14:03 -0500
Date: Thu, 1 Feb 2018 18:14:00 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <151750158646.25362.1223827961909004866.malone@wampee.canonical.com>
Message-ID: <alpine.BSF.2.21.1802011806350.32253@zero.eik.bme.hu>
References: <149985188503.15456.11517595781983565935.malonedeb@wampee.canonical.com>
	<151750158646.25362.1223827961909004866.malone@wampee.canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: Re: [Qemu-devel] [Bug 1703795] Re: Unable to release mouse in SDL2
 mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel Berrange <1703795@bugs.launchpad.net>
Cc: qemu-devel@nongnu.org

On Thu, 1 Feb 2018, Daniel Berrange wrote:
> Can you file a separate bug for the SDL1  backspace problem - it was not
> intended to cause problems like that.

Unless you want it tracked in a bug I'm happy with a fix submitted to the 
list eventually without being separately tracked on launchpad. I would've 
reported this on the mailing list normally but since this is also relevant 
here due to SDL2 also not uasable beacause of this bug I've commented 
here so people affected by this know about both problems.
