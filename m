Received: from eggs.gnu.org ([2001:4830:134:3::10]:36833)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1ddci1-0004dV-5o
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 09:33:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1ddcge-0005yk-Hf
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 09:32:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42176)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1ddcgd-0005ud-IA
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 09:30:44 -0400
References: <20170804091403.13478-1-lprosek@redhat.com>
	<20170804091403.13478-2-lprosek@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <4be87c8a-97d5-35dd-e69a-f1f48567decf@redhat.com>
Date: Fri, 4 Aug 2017 15:30:37 +0200
MIME-Version: 1.0
In-Reply-To: <20170804091403.13478-2-lprosek@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/3] i386/kvm: use a switch statement for
 MSR detection
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ladi Prosek <lprosek@redhat.com>, qemu-devel@nongnu.org, kvm@vger.kernel.org
Cc: pbonzini@redhat.com, mtosatti@redhat.com, rkrcmar@redhat.com

On 04.08.2017 11:14, Ladi Prosek wrote:
> Switch is easier on the eye and might lead to better codegen.
> 
> Signed-off-by: Ladi Prosek <lprosek@redhat.com>


Reviewed-by: David Hildenbrand <david@redhat.com>

-- 

Thanks,

David
