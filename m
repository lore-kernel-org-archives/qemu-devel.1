Received: from eggs.gnu.org ([2001:4830:134:3::10]:58540)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1cQU1g-00045i-UA
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 02:05:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1cQU1c-0000V1-8Q
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 02:05:52 -0500
Received: from szxga02-in.huawei.com ([119.145.14.65]:7454)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1cQU1b-00008X-TQ
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 02:05:48 -0500
Message-ID: <58733617.3050503@huawei.com>
Date: Mon, 9 Jan 2017 15:04:55 +0800
From: "Longpeng (Mike)" <longpeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] Question about add AF_ALG backend for virtio-crypto
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, stefanha@redhat.com, Paolo
	Bonzini <pbonzini@redhat.com>
Cc: QEMU-DEV <qemu-devel@nongnu.org>, "Wubin (H)" <wu.wubin@huawei.com>, "Zhoujian (jay, Euler)" <jianjay.zhou@huawei.com>, Gonglei <arei.gonglei@huawei.com>, longpeng2@huawei.com

Hi guys,

I'm one of Gonglei's virtio-crypto project members, and we plan to add a AF_ALG
backend for virtio-crypto(there's only builtin-backend currently).

I found that Catalin, Paolo and Stefan had discussed about this in 2015
(http://www.spinics.net/lists/kvm/msg115457.html), but it seems that Catalin
didn't do it, so I'm confuse about wether it is need to add a AF_ALG backend.

Do you have any suggestion? Thanks :)

-- 
Regards,
Longpeng(Mike)
