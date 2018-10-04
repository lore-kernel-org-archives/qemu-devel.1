Received: from eggs.gnu.org ([2001:4830:134:3::10]:35230)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pkrempa@redhat.com>) id 1g81tc-0004b0-Lj
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 07:34:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pkrempa@redhat.com>) id 1g81tZ-0000BS-EY
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 07:34:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57354)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pkrempa@redhat.com>) id 1g81tZ-0008Sx-8K
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 07:34:17 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 06DA7308124B
	for <qemu-devel@nongnu.org>; Thu,  4 Oct 2018 11:34:16 +0000 (UTC)
Date: Thu, 4 Oct 2018 13:34:12 +0200
From: Peter Krempa <pkrempa@redhat.com>
Message-ID: <20181004113412.GI21448@angien.pipo.sk>
References: <1f7db2e27758f26d4c10f7a8ed1d8232635f6909.1536044449.git.pkrempa@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f7db2e27758f26d4c10f7a8ed1d8232635f6909.1536044449.git.pkrempa@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qapi: Add vim magic modelines for qapi
 definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>

On Tue, Sep 04, 2018 at 09:03:10 +0200, Peter Krempa wrote:
> The files have a json suffix but look terrible with json syntax
> hilighting enabled. Add a magic modeline for vim to switch to python
> file format for hilighting similarly to the emacs modeline already
> present.
> 
> Signed-off-by: Peter Krempa <pkrempa@redhat.com>
> ---

Ping?
