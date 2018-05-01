Received: from eggs.gnu.org ([2001:4830:134:3::10]:33657)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fDUv5-0000FM-P5
	for qemu-devel@nongnu.org; Tue, 01 May 2018 09:02:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fDUv1-0001dx-Us
	for qemu-devel@nongnu.org; Tue, 01 May 2018 09:02:11 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54398 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fDUv1-0001de-Qc
	for qemu-devel@nongnu.org; Tue, 01 May 2018 09:02:07 -0400
References: <87o9inxkd1.fsf@dusky.pond.sub.org>
	<20180430065235.577-1-aik@ozlabs.ru>
From: Eric Blake <eblake@redhat.com>
Message-ID: <115942c3-ac74-7cc2-6683-98a6dffc7d6c@redhat.com>
Date: Tue, 1 May 2018 08:01:58 -0500
MIME-Version: 1.0
In-Reply-To: <20180430065235.577-1-aik@ozlabs.ru>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH qemu] qom: Document
 qom/device-list-properties implementation specific
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On 04/30/2018 01:52 AM, Alexey Kardashevskiy wrote:
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---

There is no rationale in the commit body (a good commit message has a 
one-line summary of "what", then a paragraph stating "why", making it 
easier for the reviewer to check that the patch itself is the "how" that 
matches the commit message).

Also, when sending a new patch, it's best to send it as a new top-level 
thread, rather than in-reply-to an older thread that has already seen 
review commentary (otherwise, it's likely to get missed in the noise).


-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
