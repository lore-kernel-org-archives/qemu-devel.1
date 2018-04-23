Received: from eggs.gnu.org ([2001:4830:134:3::10]:44838)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fAS2n-0007KS-0D
	for qemu-devel@nongnu.org; Sun, 22 Apr 2018 23:21:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fAS2j-0003FC-2h
	for qemu-devel@nongnu.org; Sun, 22 Apr 2018 23:21:32 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51160 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fAS2i-0003EY-Tr
	for qemu-devel@nongnu.org; Sun, 22 Apr 2018 23:21:29 -0400
References: <20151128034327.2137.99161.malonedeb@wampee.canonical.com>
	<152424561210.19798.13655458815806919532.malone@soybean.canonical.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <859b23a0-5e33-81ba-1832-2828cbfa2591@redhat.com>
Date: Mon, 23 Apr 2018 05:21:20 +0200
MIME-Version: 1.0
In-Reply-To: <152424561210.19798.13655458815806919532.malone@soybean.canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Bug 1520730] Re: 32-bit editors vim/rhide broken
 keyboard handling in freedos 1.1 and ms-dos 6.22
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bug 1520730 <1520730@bugs.launchpad.net>, qemu-devel@nongnu.org
Cc: "Daniel P. Berrange" <berrange@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

On 20.04.2018 19:33, Jason Wagner wrote:
> I'm seeing this issue in version 2.12.0-rc4. I wasn't seeing this as
> much in earlier 2.11, but its a major pain in the current version.

Any chance you could bi-sect this issue to find out which commit exactly
is causing the problem?

 Thomas
