Received: from eggs.gnu.org ([2001:4830:134:3::10]:44752)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eJyTY-00088J-NK
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 04:16:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eJyTU-00040W-Of
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 04:16:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33262)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eJyTU-0003z0-JS
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 04:16:12 -0500
References: <20171129040013.11804-1-famz@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5668b55b-9821-fecf-e640-48bacb9714a2@redhat.com>
Date: Wed, 29 Nov 2017 10:16:04 +0100
MIME-Version: 1.0
In-Reply-To: <20171129040013.11804-1-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH qemu-web v2] Suggest qemu-web prefix in the
 introductory post
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: yu.ning@linux.intel.com, eblake@redhat.com

On 29/11/2017 05:00, Fam Zheng wrote:
> Chances are qemu-devel@nongnu.org patches only adding new files can be
> picked up by patchew and treated like a qemu.git patch. Patchew already
> ignores [qemu-web] patches, so suggest it in this article as well. (Are
> there better places to document this?)

Maybe the contribute page should have a link to the blog post?

Thanks,

Paolo
