Received: from eggs.gnu.org ([2001:4830:134:3::10]:55943)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dIOSc-0003Fd-8P
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 20:04:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dIOSZ-0006QT-3Q
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 20:04:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47080)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dIOSY-0006PK-UO
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 20:04:27 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 103D1C049D5C
	for <qemu-devel@nongnu.org>; Wed,  7 Jun 2017 00:04:25 +0000 (UTC)
Date: Wed, 7 Jun 2017 08:04:21 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170607000421.GA30726@lemon.lan>
References: <20170605123908.18777-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170605123908.18777-1-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 00/19] Block layer thread safety, part 1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org

On Mon, 06/05 14:38, Paolo Bonzini wrote:
> v3->v4: rebased and included fixes in Fam's v2 pull request
>         new patch 18, fixing testsuite failures on OS X

Queued, thanks.
