Received: from eggs.gnu.org ([2001:4830:134:3::10]:53693)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dmitry@daynix.com>) id 1dolpP-0001Aw-P8
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 03:29:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dmitry@daynix.com>) id 1dolpM-0006em-L7
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 03:29:51 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:36030)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dmitry@daynix.com>) id 1dolpM-0006cA-Dl
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 03:29:48 -0400
Received: by mail-wm0-x243.google.com with SMTP id p17so5595027wmd.3
	for <qemu-devel@nongnu.org>; Mon, 04 Sep 2017 00:29:47 -0700 (PDT)
From: Dmitry Fleytman <dmitry@daynix.com>
Message-Id: <17D7366F-5413-4A0B-B984-33ED480A9A3C@daynix.com>
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Date: Mon, 4 Sep 2017 10:29:43 +0300
In-Reply-To: <20170904072353.GA19748@lemon.lan>
References: <20170903163726.16541-1-n54@gmx.com>
	<20170904072353.GA19748@lemon.lan>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] e1000: Rename the SEC symbol to SEQEC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: Kamil Rytarowski <n54@gmx.com>, qemu-devel@nongnu.org, jasowang@redhat.com

Reviewed-by: Dmitry Fleytman <dmitry@daynix.com>

> On 4 Sep 2017, at 10:23 AM, Fam Zheng <famz@redhat.com> wrote:
> 
> On Sun, 09/03 18:37, Kamil Rytarowski wrote:
>> SunOS defines SEC in <sys/time.h> as 1 (commonly used time symbols).
>> 
>> This fixes build on SmartOS (Joyent).
>> 
>> Patch cherry-picked from pkgsrc by jperkin (Joyent).
>> 
>> Signed-off-by: Kamil Rytarowski <n54@gmx.com>
> 
> Cc Jason Wang (net maintainer).
> 
> Fam
