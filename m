Received: from eggs.gnu.org ([2001:4830:134:3::10]:57291)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dj@redhat.com>) id 1ez8WS-0005sj-Ju
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 18:17:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dj@redhat.com>) id 1ez8WP-0004Wb-F7
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 18:17:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38388)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dj@redhat.com>) id 1ez8WP-0004W6-8s
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 18:17:21 -0400
From: DJ Delorie <dj@redhat.com>
In-Reply-To: <20180322220924.GJ2787@redhat.com> (rjones@redhat.com)
Date: Thu, 22 Mar 2018 18:17:16 -0400
Message-ID: <xnbmfflpqr.fsf@greed.delorie.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3] RISC-V: Fix riscv_isa_string memory
 size bug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Richard W.M. Jones" <rjones@redhat.com>
Cc: mjc@sifive.com, f4bug@amsat.org, qemu-devel@nongnu.org, palmer@sifive.com, peter.maydell@linaro.org

"Richard W.M. Jones" <rjones@redhat.com> writes:
> DJ, am I remembering correctly that you tried the test case on the
> HiFive evaluation board and it didn't demonstrate the bug?

I tested it on the vc707 board, without seeing the bug.

I can test other test cases if needed, I've got the board running Fedora
at the moment.
