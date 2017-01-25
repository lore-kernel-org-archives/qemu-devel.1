Received: from eggs.gnu.org ([2001:4830:134:3::10]:48141)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imbrenda@linux.vnet.ibm.com>) id 1cWRnK-00005q-Uf
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 12:55:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imbrenda@linux.vnet.ibm.com>) id 1cWRnH-0002Ga-3e
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 12:55:43 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47777)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imbrenda@linux.vnet.ibm.com>)
	id 1cWRnG-0002GJ-OZ
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 12:55:39 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v0PHrf6f143067
	for <qemu-devel@nongnu.org>; Wed, 25 Jan 2017 12:55:37 -0500
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0a-001b2d01.pphosted.com with ESMTP id 286xtq5gqg-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 25 Jan 2017 12:55:37 -0500
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <imbrenda@linux.vnet.ibm.com>;
	Wed, 25 Jan 2017 17:55:34 -0000
References: <1477674916-6795-1-git-send-email-imbrenda@linux.vnet.ibm.com>
	<1477674916-6795-3-git-send-email-imbrenda@linux.vnet.ibm.com>
	<35659f5a-cefe-29ce-ac5b-7959f476fb19@redhat.com>
From: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
Date: Wed, 25 Jan 2017 18:55:31 +0100
MIME-Version: 1.0
In-Reply-To: <35659f5a-cefe-29ce-ac5b-7959f476fb19@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Message-Id: <0aea9190-b3aa-af45-7b92-93018b33c29b@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v3 2/2] gdbstub: Fix vCont behaviour
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: palves@redhat.com, borntraeger@de.ibm.com

I applied all your suggestions


Claudio
