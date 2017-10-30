Received: from eggs.gnu.org ([2001:4830:134:3::10]:48416)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1e99iY-0005Vr-JE
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 09:03:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1e99iU-0006sB-S4
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 09:03:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39674)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1e99iU-0006s3-Lh
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 09:02:58 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EEEC837EEF
	for <qemu-devel@nongnu.org>; Mon, 30 Oct 2017 13:02:56 +0000 (UTC)
Received: from localhost (ovpn-12-99.pek2.redhat.com [10.72.12.99])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A3A3B155BFB
	for <qemu-devel@nongnu.org>; Mon, 30 Oct 2017 13:02:55 +0000 (UTC)
Date: Mon, 30 Oct 2017 21:02:51 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20171030130251.GA25066@lemon>
References: <20171030112112.6952-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171030112112.6952-1-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/6] Improve info migrate output on
 destination
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

On Mon, 10/30 12:21, Juan Quintela wrote:
> Hi
> 
> This series (on top of my last pull requset) do:

For patchew,

Based-on: 20171029130934.4555-1-quintela@redhat.com
