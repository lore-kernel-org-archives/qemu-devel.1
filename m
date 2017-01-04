Received: from eggs.gnu.org ([2001:4830:134:3::10]:37870)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1cOa8Y-0004si-Dz
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 20:13:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1cOa8X-0003tn-LN
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 20:13:06 -0500
References: <1482896059-12020-1-git-send-email-zhang.zhanghailiang@huawei.com>
	<20170103160629.GH14707@stefanha-x1.localdomain>
From: Hailiang Zhang <zhang.zhanghailiang@huawei.com>
Message-ID: <586C4C01.80404@huawei.com>
Date: Wed, 4 Jan 2017 09:12:33 +0800
MIME-Version: 1.0
In-Reply-To: <20170103160629.GH14707@stefanha-x1.localdomain>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Resend PATCH] The QEMU crashes since invoking
 qemu_thread_set_name(), the backtrace is:
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, Caoxinhua <caoxinhua@huawei.com>, arei.gonglei@huawei.com, pbonzini@redhat.com, herongguang.he@huawei.com

Oops, I deleted the original  title carelessly, will send V2. Thanks.

On 2017/1/4 0:06, Stefan Hajnoczi wrote:
> Please follow the conventions for commit messages.  QEMU commit messages
> start with a prefix that identifies the affected component.
>
> (Use git-log(1) to check what prefix other people have used for the
> file(s) you touched.)
>
> The commit message should be brief and doesn't need to be a full
> sentence.
>
> For example:
>
>    qemu-thread: fix qemu_thread_set_name() race in qemu_thread_create()
>
> Thanks,
> Stefan
