Received: from eggs.gnu.org ([2001:4830:134:3::10]:33198)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sochin.jiang@huawei.com>) id 1dL2Gb-0007yv-8z
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 02:59:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sochin.jiang@huawei.com>) id 1dL2Ga-0000rm-HW
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 02:59:01 -0400
References: <1497421359-32660-1-git-send-email-sochin.jiang@huawei.com>
	<149742200653.867.12572700830823857400@4a9a010726c0>
	<20170614064622.GD25748@lemon>
From: "sochin.jiang" <sochin.jiang@huawei.com>
Message-ID: <ad31bad0-6ff7-b8fe-5336-08e107401051@huawei.com>
Date: Wed, 14 Jun 2017 14:58:38 +0800
MIME-Version: 1.0
In-Reply-To: <20170614064622.GD25748@lemon>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] fix: avoid infinite loop when blockjob
 encountering failure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, xieyingtai@huawei.com, lina.lulina@huawei.com, lizhengui@huawei.com, qemu-block@nongnu.org, subo7@huawei.com, eric.fangyi@huawei.com, zhangshuai13@huawei.com


All right, Thanks...


On 2017/6/14 14:46, Fam Zheng wrote:
> On Tue, 06/13 23:33, no-reply@patchew.org wrote:
>> In file included from /tmp/qemu-test/src/hw/net/vmxnet3.c:30:
>> /tmp/qemu-test/src/include/migration/register.h:18: error: redefinition of typedef ‘LoadStateHandler’
>> /tmp/qemu-test/src/include/migration/vmstate.h:32: note: previous declaration of ‘LoadStateHandler’ was here
> Please ignore this error for now, the bug is on master.
>
> Fam
>
> .
>
