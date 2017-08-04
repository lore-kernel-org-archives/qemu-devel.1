Received: from eggs.gnu.org ([2001:4830:134:3::10]:36532)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1ddWW9-0004DM-NI
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 02:55:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1ddWW8-0006kV-VS
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 02:55:29 -0400
Date: Fri, 4 Aug 2017 14:55:06 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170804065506.GA30690@lemon.lan>
References: <1501825872-12555-1-git-send-email-gengdongjiu@huawei.com>
	<150182648212.60.18351046270646942452@93e45bedd699>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <150182648212.60.18351046270646942452@93e45bedd699>
Subject: Re: [Qemu-devel] [PATCH v8 0/3] Generate APEI GHES table and
 dynamically record CPER
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: gengdongjiu@huawei.com, lersek@redhat.com, mst@redhat.com, imammedo@redhat.com, zhaoshenglong@huawei.com, peter.maydell@linaro.org, qemu-arm@nongnu.org, zhengqiang10@huawei.com, wuquanming@huawei.com, huangshaoyu@huawei.com

On Thu, 08/03 23:01, no-reply@patchew.org wrote:
> /var/tmp/patchew-tester-tmp-2j515e8v/src/tcg/tcg-op.c:3056:1: fatal error: error writing to /tmp/cc9gtyQ1.s: No space left on device

Sorry, it is a false positive. I will clean up the disk space and rerun the
test. Sorry for the noise.

Fam
