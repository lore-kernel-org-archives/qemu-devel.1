Received: from eggs.gnu.org ([2001:4830:134:3::10]:42166)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1d7gQh-0004kd-OL
	for qemu-devel@nongnu.org; Mon, 08 May 2017 07:02:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1d7gQh-0001gG-0h
	for qemu-devel@nongnu.org; Mon, 08 May 2017 07:02:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38892)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1d7gQg-0001g8-QQ
	for qemu-devel@nongnu.org; Mon, 08 May 2017 07:02:14 -0400
References: <20170302024110.3978-1-rth@twiddle.net>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <c2b3410c-2bd0-f6d1-8cd4-4fa54d83ba26@redhat.com>
Date: Mon, 8 May 2017 13:02:11 +0200
MIME-Version: 1.0
In-Reply-To: <20170302024110.3978-1-rth@twiddle.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/6] target/s390x patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org

On 02.03.2017 03:41, Richard Henderson wrote:
> Herein find my 3 year old STFLE patch, two of the patches that were
> posted this week for LPP and LPD, and three patches to convert the
> atomic operations in the s390 frontend to actually be atomic.

 Hi Richard,

since the STFLE (and the other patches) missed QEMU 2.9 ... could we
please get this now into 2.10 instead, so that it should be finally
possible to run recent s390 Linux guests with TCG again?

 Thanks,
  Thomas
