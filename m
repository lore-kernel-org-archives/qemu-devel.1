Received: from eggs.gnu.org ([2001:4830:134:3::10]:35688)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <xiechanglong.d@gmail.com>) id 1dg4dI-0000Yb-S9
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 03:45:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <xiechanglong.d@gmail.com>) id 1dg4dH-0002Ff-UY
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 03:45:24 -0400
References: <20170810080108.31047-1-famz@redhat.com>
From: Xie Changlong <xiechanglong.d@gmail.com>
Message-ID: <0892fdd2-4a24-8e8c-a283-3f22ad39b411@gmail.com>
Date: Fri, 11 Aug 2017 15:44:46 +0800
MIME-Version: 1.0
In-Reply-To: <20170810080108.31047-1-famz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] file-posix: Clear out first sector in
 hdev_create
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

在 8/10/2017 4:01 PM, Fam Zheng 写道:
> People get surprised when, after "qemu-imc create -f raw /dev/sdX", they

s/qemu-imc/qemu-img/

> still see qcow2 with "qemu-img info", if previously the bdev had a qcow2

-- 
Thanks
     -Xie
