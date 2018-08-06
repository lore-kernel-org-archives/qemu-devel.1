Received: from eggs.gnu.org ([2001:4830:134:3::10]:50318)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fmiqr-00008R-Hr
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 12:59:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fmiqo-00022O-AZ
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 12:59:25 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34570 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fmiqo-00021m-3w
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 12:59:22 -0400
References: <1531213054-63327-1-git-send-email-jingqi.liu@intel.com>
	<83838432-354e-d504-a988-aa7672814822@redhat.com>
	<54526497-76bb-eba2-a4f9-b381f2436452@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <88cdf38e-8f1e-4f66-a5b5-e99d7f984f98@redhat.com>
Date: Mon, 6 Aug 2018 18:59:18 +0200
MIME-Version: 1.0
In-Reply-To: <54526497-76bb-eba2-a4f9-b381f2436452@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/3] x86/cpu: Enable a few new cpu features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Liu, Jingqi" <jingqi.liu@intel.com>, rth@twiddle.net, ehabkost@redhat.com
Cc: qemu-devel@nongnu.org, wei.w.wang@intel.com

On 06/08/2018 10:21, Liu, Jingqi wrote:
> Hi Paolo & Eduardo,
> 
> Do you have any comments for the series ?
> Thanks
> 

Hi,

QEMU is currently in feature freeze.  We will look at the series soon
after QEMU 3.0 is released.

Paolo
