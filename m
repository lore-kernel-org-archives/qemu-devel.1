Received: from eggs.gnu.org ([2001:4830:134:3::10]:53377)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d3IQw-0003Hn-Kb
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 04:36:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d3IQr-0000xM-OW
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 04:36:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34626)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1d3IQr-0000wq-ID
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 04:36:17 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 38449E9A2F
	for <qemu-devel@nongnu.org>; Wed, 26 Apr 2017 08:36:16 +0000 (UTC)
References: <20170419144219.20371-1-pbonzini@redhat.com>
	<20170419144219.20371-2-pbonzini@redhat.com>
	<c05d36c8-28a1-aa2e-1540-e799e1aa9e74@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b234b9d7-39c7-d4d9-2612-7bce670f4075@redhat.com>
Date: Wed, 26 Apr 2017 10:36:08 +0200
MIME-Version: 1.0
In-Reply-To: <c05d36c8-28a1-aa2e-1540-e799e1aa9e74@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 01/11] blockjob: remove unnecessary check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>



On 25/04/2017 01:19, John Snow wrote:
> Worth a resend to CC qemu-block, include a cover letter, and all the
> usual amenities?

The cover letter was there, but yes, I'll ensure Jeff and qemu-block are
CCed on all patches.

Paolo
