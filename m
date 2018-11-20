Received: from eggs.gnu.org ([2001:4830:134:3::10]:39545)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gPA1U-0005s9-1B
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 12:41:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gPA1Q-0007OX-23
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 12:41:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48414)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gPA1P-0007Na-Rc
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 12:41:11 -0500
References: <20181120092542.13102-1-david@redhat.com>
	<20181120092542.13102-8-david@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <4831412b-4f0b-e8ff-dc71-e476aa482e87@redhat.com>
Date: Tue, 20 Nov 2018 11:41:07 -0600
MIME-Version: 1.0
In-Reply-To: <20181120092542.13102-8-david@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 7/9] test-string-input-visitor: Use
 virtual walk
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>

On 11/20/18 3:25 AM, David Hildenbrand wrote:
> We now support virtual walks, so use that instead.
> 
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>   tests/test-string-input-visitor.c | 36 +++++++++++--------------------
>   1 file changed, 12 insertions(+), 24 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
