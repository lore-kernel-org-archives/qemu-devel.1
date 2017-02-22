Received: from eggs.gnu.org ([2001:4830:134:3::10]:59362)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cgSHh-0004yP-SV
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 03:28:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cgSHe-00065M-QP
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 03:28:25 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:35158)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cgSHe-000651-Jj
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 03:28:22 -0500
Received: by mail-wm0-x242.google.com with SMTP id u63so973899wmu.2
	for <qemu-devel@nongnu.org>; Wed, 22 Feb 2017 00:28:22 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <20170222015243.bzcnin2xbygak4wl@XZHOUW.usersys.redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e59d5584-fa25-a925-65b8-7394f51c0390@redhat.com>
Date: Wed, 22 Feb 2017 09:28:21 +0100
MIME-Version: 1.0
In-Reply-To: <20170222015243.bzcnin2xbygak4wl@XZHOUW.usersys.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] Starting kvm/qemu guest crash kernel linux-next
 0221 tree
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Xiong Zhou <xzhou@redhat.com>, qemu-devel@nongnu.org, kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-next@vger.kernel.org



On 22/02/2017 02:52, Xiong Zhou wrote:
> Hi,
> 
> Starting a guest begin to crash kernel on 0221 -next tree.
> 
> It's fine on 0220 tree.

Can you try commits a26d553400b30b6e0389f5c723c0fc6f7ea473da (0221) and
b95234c840045b7c72380fd14c59416af28fcb02 (0220)?

What is the guest and the QEMU command line?

Paolo
