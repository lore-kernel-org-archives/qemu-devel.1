Received: from eggs.gnu.org ([2001:4830:134:3::10]:52188)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fs5B7-0007pW-G5
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 07:50:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fs5B3-0006cG-HO
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 07:50:29 -0400
Date: Tue, 21 Aug 2018 13:50:19 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180821135019.1f69d8fb.cohuck@redhat.com>
In-Reply-To: <8bc0288e-e16c-c136-9701-0c3466f6f0dd@redhat.com>
References: <20180821025104.19604-1-pavel.zbitskiy@gmail.com>
	<20180821025104.19604-3-pavel.zbitskiy@gmail.com>
	<8bc0288e-e16c-c136-9701-0c3466f6f0dd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/7] target/s390x: add BAL and BALR
 instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: Pavel Zbitskiy <pavel.zbitskiy@gmail.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, richard.henderson@linaro.org, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>

On Tue, 21 Aug 2018 09:31:25 +0200
David Hildenbrand <david@redhat.com> wrote:

> Conny, can you fixup that one tcg_const_i64() ? Thanks!

Sure, done.
