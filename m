Received: from eggs.gnu.org ([2001:4830:134:3::10]:48878)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1ds2Zw-00041b-Sp
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 03:59:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1ds2Zw-0000kO-41
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 03:59:24 -0400
Date: Wed, 13 Sep 2017 15:59:14 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170913075914.GA3929@lemon>
References: <20170912144459.11359-1-pbonzini@redhat.com>
	<83c3006b-d62e-441b-57f1-dea64b141c11@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83c3006b-d62e-441b-57f1-dea64b141c11@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 00/10] cleanup qemu-iotests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, kwolf@redhat.com, qemu-block@nongnu.org

On Wed, 09/13 08:47, Thomas Huth wrote:
> Meta comment: Could we maybe also rename "tests/qemu-iotests" to
> "tests/iotests" ? The "qemu" prefix sounds always very superfluous to me
> here...

Sounds good, and saves typing for when this path is manually entered. But maybe
keep tests/qemu-iotests as a symlink to keep old scripts happy?

Fam
