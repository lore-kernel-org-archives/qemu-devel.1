Received: from eggs.gnu.org ([2001:4830:134:3::10]:37609)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lizhijian@cn.fujitsu.com>) id 1gThWt-0005tg-Lx
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 01:16:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lizhijian@cn.fujitsu.com>) id 1gThWq-0003eg-Gi
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 01:16:27 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:51306
	helo=heian.cn.fujitsu.com) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lizhijian@cn.fujitsu.com>) id 1gThWq-0003bk-4t
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 01:16:24 -0500
References: <1542765966-20244-1-git-send-email-lizhijian@cn.fujitsu.com>
	<1542765966-20244-2-git-send-email-lizhijian@cn.fujitsu.com>
	<1542765966-20244-3-git-send-email-lizhijian@cn.fujitsu.com>
	<CAFEAcA8pdUkPBYngX5_UKRf0OkGDtLZA99zMH07RWeRTh=+BvQ@mail.gmail.com>
	<CAFEAcA81nmEom5m4tVQCGwnHXxXLQBEuMJmHJx1FV_MVFVnKQw@mail.gmail.com>
From: Li Zhijian <lizhijian@cn.fujitsu.com>
Message-ID: <dbaf7e49-9039-7ff5-52a8-8c1d87cb9396@cn.fujitsu.com>
Date: Mon, 3 Dec 2018 14:16:21 +0800
MIME-Version: 1.0
In-Reply-To: <CAFEAcA81nmEom5m4tVQCGwnHXxXLQBEuMJmHJx1FV_MVFVnKQw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v2 2/5] change load_image() reture type to
 ssize_t
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Philip Li <philip.li@intel.com>, zhijianx.li@intel.com


On 11/30/2018 11:14 PM, Peter Maydell wrote:
> I'm just about to send out a patchset which removes all the
> load_image() callers; that would make patches 2 and 4 in this
> set unnecessary.

Got it, i will remove them at next version basing on your patch set.

Thanks
Zhijian
