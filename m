Received: from eggs.gnu.org ([2001:4830:134:3::10]:60463)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dvNJW-00021S-JC
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 08:44:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dvNJR-0004yh-Q7
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 08:44:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46072)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dvNJR-0004xP-KK
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 08:44:09 -0400
Date: Fri, 22 Sep 2017 20:44:05 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170922124405.GB32000@lemon>
References: <mailman.3351.1506066493.14747.qemu-devel@nongnu.org>
	<726A2123-0371-407B-9270-6672DF66D511@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <726A2123-0371-407B-9270-6672DF66D511@gmail.com>
Subject: Re: [Qemu-devel] [PULL 28/36] tests: Add ubuntu.i386 image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Programmingkid <programmingkidx@gmail.com>
Cc: "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>

On Fri, 09/22 08:10, Programmingkid wrote:
> Could a Darwin test be added? Both x86 and PowerPC versions would be great.

It's nice to cover macOS in our test, but to be honest I don't know how to do
it. If there isn't any copyright problem, and if there are instructions
available in wiki.qemu.org descirbing how to create such a guest step by step
like [1], we can add one.

[1]: https://wiki.qemu.org/Hosts/BSD

Fam
