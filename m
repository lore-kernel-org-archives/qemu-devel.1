Received: from eggs.gnu.org ([2001:4830:134:3::10]:44999)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <george.kennedy@oracle.com>) id 1gK6nU-0007bQ-S3
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 14:13:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <george.kennedy@oracle.com>) id 1gK6nP-0006eD-5Z
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 14:13:56 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:47948)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <george.kennedy@oracle.com>)
	id 1gK6nN-0006BM-0w
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 14:13:49 -0500
Message-ID: <5BE1E7D7.7020006@oracle.com>
Date: Tue, 06 Nov 2018 14:13:27 -0500
From: george kennedy <george.kennedy@oracle.com>
MIME-Version: 1.0
References: <1541019806-17696-1-git-send-email-george.kennedy@oracle.com>
	<a02c97ee-964b-45da-e585-ed1d190ed591@redhat.com>
In-Reply-To: <a02c97ee-964b-45da-e585-ed1d190ed591@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4] lsi_scsi: Reselection needed to remove
 pending commands from queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: famz@redhat.com, qemu-devel@nongnu.org, boris.ostrovsky@oracle.com


On 11/6/2018 1:58 PM, Paolo Bonzini wrote:
> On 31/10/2018 22:03, George Kennedy wrote:
>> +#define SCRIPTS_LOAD_AND_STORE  0xe2340004
> I'm very confused.  Why did this constant reappear?

Ok. Me too.

What are you proposing instead and I'll change it to that?

Did I have what you're after in a prior patch? If so, can you point to 
that clip?

Thank you,
George

>
> Paolo
>
>
