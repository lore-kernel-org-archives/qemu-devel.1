Received: from eggs.gnu.org ([2001:4830:134:3::10]:58589)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1fSQhk-0004HT-HA
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 13:34:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1fSQhh-00056B-Ti
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 13:34:08 -0400
Received: from mail-eopbgr50127.outbound.protection.outlook.com
	([40.107.5.127]:39008
	helo=EUR03-VE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1fSQhh-00055i-GF
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 13:34:05 -0400
Date: Mon, 11 Jun 2018 18:01:28 +0300
From: Roman Kagan <rkagan@virtuozzo.com>
Message-ID: <20180611150127.GA9807@rkaganip.lan>
References: <20180501132031.13270-1-viktor.prutyanov@virtuozzo.com>
	<87h8m94coh.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h8m94coh.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [PATCH v4] dump: add Windows dump format to
 dump-guest-memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Viktor Prutyanov <viktor.prutyanov@virtuozzo.com>, qemu-devel@nongnu.org, marcandre.lureau@redhat.com, dgilbert@redhat.com, Paolo Bonzini <pbonzini@redhat.com>

On Mon, Jun 11, 2018 at 04:31:42PM +0200, Markus Armbruster wrote:
> Looks stuck.

Indeed.

FWIW Viktor submitted a bigger series

  Subject: [PATCH 0/4] dump: add Windows crashdump format
  Date: Thu, 17 May 2018 19:23:38 +0300
  Message-Id: <20180517162342.4330-1-viktor.prutyanov@virtuozzo.com>

that included this patch as the first one, but also added the ability to
create useful dumps on a live guest.

If it can get any review that would be appreciated.

Thanks,
Roman.
