Received: from eggs.gnu.org ([2001:4830:134:3::10]:52009)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eK48X-0005Dt-H6
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 10:19:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eK48W-0003vR-KX
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 10:18:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35070)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eK48W-0003t8-Ev
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 10:18:56 -0500
References: <20171129040013.11804-1-famz@redhat.com>
	<5668b55b-9821-fecf-e640-48bacb9714a2@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a6d2a5cd-635c-a55b-4d4e-05f79fcd29c1@redhat.com>
Date: Wed, 29 Nov 2017 09:18:49 -0600
MIME-Version: 1.0
In-Reply-To: <5668b55b-9821-fecf-e640-48bacb9714a2@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
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
To: Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: yu.ning@linux.intel.com

On 11/29/2017 03:16 AM, Paolo Bonzini wrote:
> On 29/11/2017 05:00, Fam Zheng wrote:
>> Chances are qemu-devel@nongnu.org patches only adding new files can be
>> picked up by patchew and treated like a qemu.git patch. Patchew already
>> ignores [qemu-web] patches, so suggest it in this article as well. (Are
>> there better places to document this?)
> 
> Maybe the contribute page should have a link to the blog post?

Additionally, we should have a mention of qemu-web.git somewhere within 
qemu.git.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
