Received: from eggs.gnu.org ([2001:4830:134:3::10]:43358)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eRwtR-0002l8-OM
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 04:11:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eRwtM-000205-Q8
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 04:11:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39926)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eRwtM-0001zJ-K4
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 04:11:52 -0500
References: <1511859789-43680-1-git-send-email-arei.gonglei@huawei.com>
	<33183CC9F5247A488A2544077AF19020DA4ED5D3@DGGEMA505-MBX.china.huawei.com>
	<20171220193658-mutt-send-email-mst@kernel.org>
	<33183CC9F5247A488A2544077AF19020DA4F143F@DGGEMA505-MBX.china.huawei.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <63d06274-317f-f3a4-0c75-6ab835d3886a@redhat.com>
Date: Thu, 21 Dec 2017 10:11:39 +0100
MIME-Version: 1.0
In-Reply-To: <33183CC9F5247A488A2544077AF19020DA4F143F@DGGEMA505-MBX.china.huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/4] cryptodev: add vhost support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Gonglei (Arei)" <arei.gonglei@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Huangweidong (C)" <weidong.huang@huawei.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "Zhoujian (jay)" <jianjay.zhou@huawei.com>, "pasic@linux.vnet.ibm.com" <pasic@linux.vnet.ibm.com>, longpeng <longpeng2@huawei.com>, "xin.zeng@intel.com" <xin.zeng@intel.com>, "roy.fan.zhang@intel.com" <roy.fan.zhang@intel.com>

On 21/12/2017 01:51, Gonglei (Arei) wrote:
> Sorry, Michael. This makes me confused. Because the Qemu part about vhost-user crypto 
> doesn't do this assumption. The main controversial point is whether session operations
> should be added in the vhost-user protocol, raised by Paolo. And we made an explanation. 

Indeed, that's fine for me.

Paolo
