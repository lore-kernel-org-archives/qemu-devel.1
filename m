Received: from eggs.gnu.org ([2001:4830:134:3::10]:38122)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dg7ns-0006OC-P8
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 07:08:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dg7np-0007bD-Ks
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 07:08:32 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60615
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1dg7np-0007ay-GE
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 07:08:29 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7BB3ePm080481
	for <qemu-devel@nongnu.org>; Fri, 11 Aug 2017 07:08:28 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2c984g99j6-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 11 Aug 2017 07:08:28 -0400
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Fri, 11 Aug 2017 12:08:26 +0100
References: <1502359588-29451-1-git-send-email-armbru@redhat.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Fri, 11 Aug 2017 13:08:22 +0200
MIME-Version: 1.0
In-Reply-To: <1502359588-29451-1-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <eb2cf3a3-e591-bb04-a8e2-c813c38ded9f@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] error: Improve documentation of
 error_append_hint()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: mdroth@linux.vnet.ibm.com



On 08/10/2017 12:06 PM, Markus Armbruster wrote:
> Suggested-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Nice clarification!

Reviewed-by: Halil Pasic <pasic@linux.vnet.ibm.com>
