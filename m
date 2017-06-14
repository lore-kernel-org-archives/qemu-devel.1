Received: from eggs.gnu.org ([2001:4830:134:3::10]:58805)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dL24W-0007TN-NA
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 02:46:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dL24V-0005k0-Up
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 02:46:32 -0400
Date: Wed, 14 Jun 2017 14:46:22 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170614064622.GD25748@lemon>
References: <1497421359-32660-1-git-send-email-sochin.jiang@huawei.com>
	<149742200653.867.12572700830823857400@4a9a010726c0>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <149742200653.867.12572700830823857400@4a9a010726c0>
Content-Transfer-Encoding: quoted-printable
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
To: qemu-devel@nongnu.org
Cc: sochin.jiang@huawei.com, kwolf@redhat.com, mreitz@redhat.com, xieyingtai@huawei.com, lina.lulina@huawei.com, lizhengui@huawei.com, qemu-block@nongnu.org, subo7@huawei.com, eric.fangyi@huawei.com, zhangshuai13@huawei.com

On Tue, 06/13 23:33, no-reply@patchew.org wrote:
> In file included from /tmp/qemu-test/src/hw/net/vmxnet3.c:30:
> /tmp/qemu-test/src/include/migration/register.h:18: error: redefinition=
 of typedef =E2=80=98LoadStateHandler=E2=80=99
> /tmp/qemu-test/src/include/migration/vmstate.h:32: note: previous decla=
ration of =E2=80=98LoadStateHandler=E2=80=99 was here

Please ignore this error for now, the bug is on master.

Fam
