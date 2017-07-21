Received: from eggs.gnu.org ([2001:4830:134:3::10]:55213)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dYOYP-0001Z2-Cx
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 23:24:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dYOYM-0001KI-Ao
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 23:24:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39470)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dYOYM-0001Jg-4G
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 23:24:34 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 16D9F6CB4C
	for <qemu-devel@nongnu.org>; Fri, 21 Jul 2017 03:24:33 +0000 (UTC)
Date: Fri, 21 Jul 2017 11:24:30 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170721032430.GP11032@lemon>
References: <20170717063521.GA7393@lemon>
 <20170717100206.GF3640@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170717100206.GF3640@redhat.com>
Subject: Re: [Qemu-devel] Status and RFC of patchew testings on QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org

On Mon, 07/17 11:02, Daniel P. Berrange wrote:
> I'd like to see a web page that provides a list of all mail threads that
> the test system has queued, with status of which jobs and running, and
> once completed, provides the full logs.

The index page already exists (no running jobs information, though):

http://patchew.org/QEMU/

Fam
