Received: from eggs.gnu.org ([2001:4830:134:3::10]:36319)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cXRbx-0003qj-Q5
	for qemu-devel@nongnu.org; Sat, 28 Jan 2017 06:56:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cXRbx-00071G-4a
	for qemu-devel@nongnu.org; Sat, 28 Jan 2017 06:56:05 -0500
Date: Sat, 28 Jan 2017 19:55:56 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170128115556.GA3969@lemon>
References: <20170126110435.2777-1-berrange@redhat.com>
	<20170126110435.2777-4-berrange@redhat.com>
	<20170126123530.GB23095@lemon.Home>
	<20170126132708.GB29127@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170126132708.GB29127@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v1 3/6] qemu-img: add support for -n arg to
 dd command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On Thu, 01/26 13:27, Daniel P. Berrange wrote:
> It would be trivial to rewrite this patch to add support for the "conv"
> option, allowing the user to explicitly give 'qemu-img dd conv=nocreat'
> instead of my 'qemu-img dd -n' syntax, without changing default semantics.

OK, that would be an undebatably way to do this.

Fam
