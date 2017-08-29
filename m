Received: from eggs.gnu.org ([2001:4830:134:3::10]:58378)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dmdBk-0000z1-1B
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 05:52:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dmdBe-0006Eo-Tw
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 05:52:04 -0400
Received: from mail-wm0-x233.google.com ([2a00:1450:400c:c09::233]:34953)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dmdBe-0006EV-N8
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 05:51:58 -0400
Received: by mail-wm0-x233.google.com with SMTP id y71so17448076wmd.0
	for <qemu-devel@nongnu.org>; Tue, 29 Aug 2017 02:51:58 -0700 (PDT)
Date: Tue, 29 Aug 2017 10:51:55 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170829095155.GJ25960@stefanha-x1.localdomain>
References: <20170828015654.2530-1-Sergio.G.DelReal@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170828015654.2530-1-Sergio.G.DelReal@gmail.com>
Subject: Re: [Qemu-devel] [PATCH 00/14] add support for Hypervisor.framework
 in QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sergio Andres Gomez Del Real <sergio.g.delreal@gmail.com>
Cc: qemu-devel@nongnu.org

On Sun, Aug 27, 2017 at 08:56:40PM -0500, Sergio Andres Gomez Del Real wrote:
> The following patchset adds to QEMU the supporting for macOS's native
> hypervisor, Hypervisor.framework (hvf). The code base is taken from
> Google's Android emulator at
> https://android.googlesource.com/platform/external/qemu/+/emu-master-dev.

What is the status of this feature?  Is it expected to run everything
that TCG can run or are there limitations?  Is live migration supported,
etc?

How do you test hvf?  Are there automated test cases?

Stefan
