Received: from eggs.gnu.org ([2001:4830:134:3::10]:54217)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dlCbn-0005bP-5Q
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 07:17:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dlCbi-0004aA-9W
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 07:17:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57200)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dlCbi-0004YJ-2O
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 07:16:58 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5317B7E436
	for <qemu-devel@nongnu.org>; Fri, 25 Aug 2017 11:16:55 +0000 (UTC)
Message-ID: <1503659812.9107.4.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 25 Aug 2017 13:16:52 +0200
In-Reply-To: <1503602048-12268-9-git-send-email-armbru@redhat.com>
References: <1503602048-12268-1-git-send-email-armbru@redhat.com>
	<1503602048-12268-9-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 08/16] qapi-schema: Collect UI stuff in
 qapi/ui.json
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, eblake@redhat.com

On Thu, 2017-08-24 at 21:14 +0200, Markus Armbruster wrote:
> UI stuff is remote desktop stuff (Spice, VNC) and input stuff (mouse,
> keyboard).
> 
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>

cheers,
  Gerd
