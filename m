Received: from eggs.gnu.org ([2001:4830:134:3::10]:46319)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <skiver.cloud.yzy@gmail.com>) id 1cTgs5-0006bM-QS
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 22:25:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <skiver.cloud.yzy@gmail.com>) id 1cTgs5-0000YG-3P
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 22:25:13 -0500
MIME-Version: 1.0
In-Reply-To: <20170118021529.GC31883@lemon.Home>
References: <1484702885-11437-1-git-send-email-skiver.cloud.yzy@gmail.com>
	<20170118021529.GC31883@lemon.Home>
From: Yang Ziyue <skiver.cloud.yzy@gmail.com>
Date: Wed, 18 Jan 2017 11:25:12 +0800
Message-ID: <CAHkcwacfme4xZhzt0_YHi9wCvp3jZ31Kz+J2sLP3L5D-HBHO4g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v3] gdbstub.c: fix GDB connection segfault
 caused by empty machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, Ziyue Yang <yzylivezh@hotmail.com>, Anthony Liguori <aliguori@us.ibm.com>

Hi Fam,

I've split the patch into 2 smaller ones and submitted them tagged with "v4".
Thanks!

Ziyue Yang

2017-01-18 10:15 GMT+08:00 Fam Zheng <famz@redhat.com>:
> On Wed, 01/18 09:28, Ziyue Yang wrote:
>> Also some updates from fprintf(stderr, ...) to error_report.
>
> Looks like they belong to a separate patch.
>
> Fam
