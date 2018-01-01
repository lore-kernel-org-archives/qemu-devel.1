Received: from eggs.gnu.org ([2001:4830:134:3::10]:51151)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <makovick@gmail.com>) id 1eW6VG-0000s5-KC
	for qemu-devel@nongnu.org; Mon, 01 Jan 2018 15:16:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <makovick@gmail.com>) id 1eW6VD-0000rC-8B
	for qemu-devel@nongnu.org; Mon, 01 Jan 2018 15:16:10 -0500
Received: from mail-lf0-x236.google.com ([2a00:1450:4010:c07::236]:43587)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <makovick@gmail.com>) id 1eW6VD-0000q4-0F
	for qemu-devel@nongnu.org; Mon, 01 Jan 2018 15:16:07 -0500
Received: by mail-lf0-x236.google.com with SMTP id o26so39798842lfc.10
	for <qemu-devel@nongnu.org>; Mon, 01 Jan 2018 12:16:06 -0800 (PST)
Date: Mon, 1 Jan 2018 21:16:00 +0100
From: =?UTF-8?B?SmluZMWZaWNoIE1ha292acSNa2E=?= <makovick@gmail.com>
Message-ID: <20180101211600.3f533781@holly>
In-Reply-To: <20171117112258.5888-1-makovick@gmail.com>
References: <20171117112258.5888-1-makovick@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4] SDL2 various fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>

On Fri, 17 Nov 2017 12:22:55 +0100
Jindrich Makovicka <makovick@gmail.com> wrote:

> Hi,
> 
> here is a respin of the three remaining patches, with checkpatch
> errors corrected.
> 
> Also added the Fixes: line for "sdl2 uses surface relative
> coordinates", and an explaining comment to "sdl2: Ignore UI hotkeys".
> 
> Regards, Jindrich
> 

Hi,

these changes somehow got lost. Any chance to have them merged into the
next minor?

Regards,
-- 
Jindrich Makovicka
