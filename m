Received: from eggs.gnu.org ([2001:4830:134:3::10]:54043)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1flAHu-0006jN-He
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 05:52:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1flAHo-0005kS-Ad
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 05:52:54 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37586 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1flAHo-0005kB-2n
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 05:52:48 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8A65B818B107
	for <qemu-devel@nongnu.org>; Thu,  2 Aug 2018 09:52:47 +0000 (UTC)
References: <1533203376-25621-1-git-send-email-thuth@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <e67f4ef0-ae10-8384-b7ed-7f2ec5513195@redhat.com>
Date: Thu, 2 Aug 2018 11:52:46 +0200
MIME-Version: 1.0
In-Reply-To: <1533203376-25621-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] tests/migration-test: Turn kvm_hv message
 into a g_debug message
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>


Sorry, I forgot to update the patch subject, it should be:

 "tests/migration-test: Silence the kvm_hv message by default"

Could you fix it up when picking up the patch, please? (or shall I resend?)

 Thomas
