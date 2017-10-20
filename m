Received: from eggs.gnu.org ([2001:4830:134:3::10]:55564)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1e5R7u-0006uW-Ko
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 02:49:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1e5R7q-0007nc-O5
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 02:49:50 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:55760)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <th.huth@gmail.com>) id 1e5R7q-0007nL-Hf
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 02:49:46 -0400
Received: by mail-wr0-f194.google.com with SMTP id z99so7978947wrc.12
	for <qemu-devel@nongnu.org>; Thu, 19 Oct 2017 23:49:45 -0700 (PDT)
References: <3ff31617-ae1d-af0f-9b27-eea73df5fe6c@gmail.com>
From: Thomas Huth <huth@tuxfamily.org>
Message-ID: <9ece2ca1-a362-c029-df19-29d85ef0f679@tuxfamily.org>
Date: Fri, 20 Oct 2017 08:49:41 +0200
MIME-Version: 1.0
In-Reply-To: <3ff31617-ae1d-af0f-9b27-eea73df5fe6c@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] unknown keycodes `(unnamed)'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Spaceboy Ross <spaceboyross@gmail.com>, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

On 19.10.2017 21:23, Spaceboy Ross wrote:
> unknown keycodes `(unnamed)', please report to qemu-devel@nongnu.org
> 
> uname -a returns:
> 
> Linux spaceboyross-Latitude-D630 4.13.0-16-generic #19-Ubuntu SMP Wed
> Oct 11 18:35:14 UTC 2017 x86_64 x86_64 x86_64 GNU/Linux
> 

Please be more specific: Which key did you press to get that output?
Which keyboard layout (language) are you using? Which version of QEMU is
this? What kind of user interface are you using (GTK? SDL? VNC?).

 Thomas
