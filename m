Received: from eggs.gnu.org ([2001:4830:134:3::10]:41263)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <roy.fan.zhang@intel.com>) id 1eAIFA-0008BS-UQ
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 12:21:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <roy.fan.zhang@intel.com>) id 1eAIF7-00088M-Qn
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 12:21:24 -0400
Received: from mga06.intel.com ([134.134.136.31]:8434)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <roy.fan.zhang@intel.com>)
	id 1eAIF7-000858-Ef
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 12:21:21 -0400
From: "Zhang, Roy Fan" <roy.fan.zhang@intel.com>
Date: Thu, 2 Nov 2017 16:21:11 +0000
Message-ID: <9F7182E3F746AB4EA17801C148F3C6043304CFF9@IRSMSX101.ger.corp.intel.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC 0/3] cryptodev: add vhost support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "arei.gonglei@huawei.com" <arei.gonglei@huawei.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

Hi Gong Lei,

How are you?

As discussed in KVM Forum, the Vhost User Crypto implementation RFC patchse=
t has been sent to dpdk.org today.
Please find the patchset here

--Cover letter
http://dpdk.org/ml/archives/dev/2017-November/081048.html

--Patches
http://dpdk.org/dev/patchwork/patch/31115/
http://dpdk.org/dev/patchwork/patch/31116/
http://dpdk.org/dev/patchwork/patch/31117/
http://dpdk.org/dev/patchwork/patch/31118/
http://dpdk.org/dev/patchwork/patch/31119/
http://dpdk.org/dev/patchwork/patch/31120/

I have tested both this patchset and my DPDK vhost user crypto patchset, wo=
rking as charm.

Best regards,
Fan
