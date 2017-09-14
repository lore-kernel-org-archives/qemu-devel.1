Received: from eggs.gnu.org ([2001:4830:134:3::10]:56583)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dsP2z-0005tk-Ei
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 03:58:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dsP2w-0008CB-Eb
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 03:58:53 -0400
References: <1503661569-11408-1-git-send-email-frederic.konrad@adacore.com>
From: Michael Tokarev <mjt@tls.msk.ru>
Message-ID: <560a5a7c-1dca-f074-7ffb-42909700b840@msgid.tls.msk.ru>
Date: Thu, 14 Sep 2017 10:58:49 +0300
MIME-Version: 1.0
In-Reply-To: <1503661569-11408-1-git-send-email-frederic.konrad@adacore.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.11] aux-to-i2c-bridge: don't allow
 user to create one
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: KONRAD Frederic <frederic.konrad@adacore.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, thuth@redhat.com

25.08.2017 14:46, KONRAD Frederic wrote:
> This device is private and is created once per aux-bus.
> So don't allow the user to create one from command-line.

Applied to -trivial, thanks!

/mjt
