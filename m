Received: from eggs.gnu.org ([2001:4830:134:3::10]:34755)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cWdu3-00037u-4n
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 01:51:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cWdu0-0000Ed-2J
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 01:51:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42966)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1cWdtz-0000EO-Se
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 01:51:23 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AEB864E4C6
	for <qemu-devel@nongnu.org>; Thu, 26 Jan 2017 06:51:23 +0000 (UTC)
Date: Thu, 26 Jan 2017 14:50:44 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170126065044.GE6879@lemon>
References: <1485365075-32702-1-git-send-email-phil@philjordan.eu>
	<148536527026.27.12814124354919992023@eba24e3a0d7f>
	<CAAibmn0YQYZKv_DfqmZ9fkW6nC=rJrrEnyadhV1QOLrLzs2f6Q@mail.gmail.com>
	<20170126012903.GA6879@lemon> <87sho6z64u.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sho6z64u.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [PATCH v3] hw/usb/dev-hid: Improve guest
 compatibility of usb-tablet
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org

On Thu, 01/26 07:29, Markus Armbruster wrote:
> With QEMU sources, you can have any tab width, as long as it is eight.

That is very permissive!

Fam
