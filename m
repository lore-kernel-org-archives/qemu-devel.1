Received: from eggs.gnu.org ([2001:4830:134:3::10]:35827)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1ekPLZ-0000Vn-Tx
	for qemu-devel@nongnu.org; Sat, 10 Feb 2018 02:13:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1ekPLX-0004O3-AB
	for qemu-devel@nongnu.org; Sat, 10 Feb 2018 02:13:17 -0500
References: <20180115023501.37361-1-aik@ozlabs.ru>
From: Michael Tokarev <mjt@tls.msk.ru>
Message-ID: <7d78a12f-1683-1df8-6ff3-58373110a2bb@msgid.tls.msk.ru>
Date: Sat, 10 Feb 2018 10:13:13 +0300
MIME-Version: 1.0
In-Reply-To: <20180115023501.37361-1-aik@ozlabs.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH qemu] configure: Allow capstone=git only if
 git update is not disabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org
Cc: QEMU Trivial <qemu-trivial@nongnu.org>

15.01.2018 05:35, Alexey Kardashevskiy wrote:
> Even with --disable-git-update, ./configure tries updating the capstone
> submodule instead of marking it "no"; this disables capstone submodule
> if git update is disabled.

Applied to -trivial, thanks!

/mjt
